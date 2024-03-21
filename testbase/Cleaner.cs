using Amazon.DynamoDBv2;
using Amazon.DynamoDBv2.DocumentModel;
using Microsoft.Extensions.DependencyInjection;

namespace testbase
{
    public static class Cleaner
    {
        public static async Task Execute(IServiceProvider serviceProvider)
        {
            await FlushDynamoDB(serviceProvider);
        }

        private static async Task FlushDynamoDB(IServiceProvider serviceProvider)
        {
            try
            {
                var amazoneDynamoDB = serviceProvider.GetRequiredService<IAmazonDynamoDB>();

                var resp = await amazoneDynamoDB.ListTablesAsync();

                foreach (var tableName in resp.TableNames)
                {
                    // 取得表格物件
                    Table table = Table.LoadTable(amazoneDynamoDB, tableName);

                    // 取得表格中的所有項目
                    ScanFilter scanFilter = new ScanFilter();
                    Search scan = table.Scan(scanFilter);

                    do
                    {
                        var documentList = await scan.GetNextSetAsync();
                        foreach (Document document in documentList)
                        {
                            // 刪除每個項目
                            await table.DeleteItemAsync(document);
                        }
                    } while (!scan.IsDone);
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}