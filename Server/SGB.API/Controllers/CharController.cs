using Microsoft.AspNetCore.Mvc;
using SGB.API.Database;

namespace SGB.API.Controllers
{
    [ApiController]
    [Route("char")]
    public class CharController : ControllerBase
    {
        private readonly CoreService _core;

        public CharController(CoreService core)
        {
            _core = core;
        }

        [HttpPost("list")]
        public void List([FromForm] string guid, [FromForm] string password)
        {
            var success = RedisService.ValidateLogin(guid, password);
            if (success)
            {
                Response.CreateError("Invalid Login");
                return;
            }

            // todo return /char/list xml
            Response.CreateError("Invalid Endpoint");
        }

        [HttpPost("purchaseClassUnlock")]
        public void PurchaseClassUnlock([FromForm] string guid, [FromForm] string password, [FromForm] string classType)
        {
            Response.CreateError("Invalid Endpoint");
        }

        [HttpPost("fame")]
        public void Fame([FromForm] string accountId, [FromForm] string charId)
        {
            Response.CreateError("Invalid Endpoint");
        }

        [HttpPost("delete")]
        public void Delete([FromForm] string guid, [FromForm] string password, [FromForm] string charId)
        {
            Response.CreateError("Invalid Endpoint");
        }
    }
}