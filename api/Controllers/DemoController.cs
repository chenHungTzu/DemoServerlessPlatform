using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;

namespace DemoServerlessPlatform.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class DemoController : ControllerBase
    {

        public DemoController(){

        }

        [HttpGet("DivisionToWrite/{number}")]
        public IActionResult DivisionToWrite(int number)
        {
            try
            {
                // // 先宣告Repository
                // var repository = new Demo_Normal_Repository();

                // // you can use 2 or 3 as the second parameter
                // repository.WriteToDatabase(new Divider(number, 3));

                return Ok();
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}