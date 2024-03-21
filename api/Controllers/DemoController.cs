using domain;
using domain.adapter;
using Microsoft.AspNetCore.Mvc;

namespace DemoServerlessPlatform.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DemoController : ControllerBase
    {
        private readonly IDividerRepository dividerRepository;

        public DemoController(IDividerRepository dividerRepository)
        {
            this.dividerRepository = dividerRepository;
        }

        /// <summary>
        ///  local : http://localhost:55005/api/Demo/DivisionToWrite/{number}
        ///  localstack : http://<agwId>.execute-api.localhost.localstack.cloud:4566/dev/api/Demo/DivisionToWrite/{number}
        ///  aws : https://<agwId>.execute-api.ap-northeast-1.amazonaws.com/dev/api/Demo/DivisionToWrite/{number}
        /// </summary>
        /// <param name="number"></param>
        /// <returns></returns>
        [HttpPost("DivisionToWrite/{number}")]
        public async Task<IActionResult> DivisionToWrite(int number)
        {
            try
            {
                await dividerRepository.WriteToDatabase(new Divider(number, 3));

                return Ok(number);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}