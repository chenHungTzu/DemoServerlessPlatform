namespace domain.adapter
{
    public interface IDividerRepository
    {
        /// <summary>
        /// 寫入數字到目標資料表
        /// </summary>
        /// <param name="divider"></param>
        /// <returns>寫入的數字</returns>
        public Task WriteToDatabase(Divider divider);
    }
}