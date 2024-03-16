using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
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

        [HttpGet("DivisionToWrite/{number}")]
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