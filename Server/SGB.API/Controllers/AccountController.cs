using Microsoft.AspNetCore.Mvc;
using SGB.API.Database;
using System;
using System.Collections.Generic;
using System.Xml.Linq;

namespace SGB.API.Controllers
{
    [ApiController]
    [Route("account")]
    public class AccountController : ControllerBase
    {
        private readonly CoreService _core;

        public AccountController(CoreService core)
        {
            _core = core;
        }

        [HttpPost("getOwnedPetSkins")]
        public void GetOwnedPetSkins([FromForm] string guid, [FromForm] string password, [FromForm] string isChallenger)
        {
            var accountId = RedisService.IsValidLogin(guid, password);
            if (accountId == -1)
            {
                Response.CreateSuccess();
                return;
            }

            var elem = new XElement("PetSkins");
            Response.CreateXML(elem.ToString());
        }

        [HttpPost("verify")]
        public void Register([FromForm] string guid, [FromForm] string password)
        {
            var accountId = RedisService.IsValidLogin(guid, password);
            if (accountId == -1)
            {
                Response.CreateError("Error.accountNotFound");
                return;
            }

            Response.CreateSuccess();
        }

        [HttpPost("register")]
        public void Register([FromForm] string guid, [FromForm] string newGUID, [FromForm] string newPassword, [FromForm] string name)
        {
            var registerResult = RedisService.Register(newGUID, newPassword, name);
            if(registerResult == null)
            {
                Response.CreateSuccess();
                return;
            }

            Response.CreateError(registerResult);
        }
    }
}