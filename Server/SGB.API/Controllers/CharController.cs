using Microsoft.AspNetCore.Mvc;

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
        public void List([FromForm] string guid, [FromForm] string password, [FromForm] string secret)
        {
            //if (_core.IsProduction())
            //{
            //    if (_core.Config.serverInfo.requireSecret && secret != "69420")
            //    {
            //        Response.InternalServerError("Internal Server Error");
            //        return;
            //    }
            //}

            //var status = _core.Database.Verify(guid, password, out var acc);
            //if (status == DbLoginStatus.OK || status == DbLoginStatus.AccountNotExists)
            //{
            //    if (status == DbLoginStatus.AccountNotExists)
            //        acc = _core.Database.CreateGuestAccount(guid);

            //    var list = CharList.FromDb(_core, acc);
            //    list.Servers = _core.GetServerList();
            //    Response.CreateXml(list.ToXml(_core).ToString());
            //    return;
            //}

            //Response.CreateError(status.GetInfo());
        }

        [HttpPost("purchaseClassUnlock")]
        public void PurchaseClassUnlock([FromForm] string guid, [FromForm] string password, [FromForm] string classType)
        {
            Response.CreateError("Invalid Endpoint");
        }

        [HttpPost("fame")]
        public void _Fame([FromForm] string accountId, [FromForm] string charId)
        {
            //var _db = _core.Database;

            //var character = _db.LoadCharacter(int.Parse(accountId), int.Parse(charId));
            //if (character == null)
            //{
            //    Response.CreateError("Invalid character");
            //    return;
            //}

            //var fame = Fame.FromDb(_core, character);
            //if (fame == null)
            //{
            //    Response.CreateError("Character not dead");
            //    return;
            //}

            //Response.CreateXml(fame.ToXml().ToString());
        }

        [HttpPost("delete")]
        public void Delete([FromForm] string guid, [FromForm] string password, [FromForm] string charId)
        {
            //var _db = _core.Database;
            //var status = _db.Verify(guid, password, out DbAccount acc);
            //if (status == DbLoginStatus.OK)
            //{
            //    using (var l = _db.Lock(acc))
            //        if (_db.LockOk(l))
            //        {
            //            _db.DeleteCharacter(acc, int.Parse(charId));
            //            Response.CreateSuccess();
            //        }
            //        else
            //            Response.CreateError("Account in Use");
            //}
            //else
            //    Response.CreateError(status.GetInfo());
        }
    }
}