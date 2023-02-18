using Microsoft.AspNetCore.Mvc;
using SGB.API.Database;
using SGB.Shared.Database;
using System.Xml.Linq;

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
            var accountId = RedisService.IsValidLogin(guid, password);

            var accountModel = RedisService.LoadAccount(accountId);
            if(accountModel == null)
            {
                accountModel = new AccountModel(accountId, RedisService.GetDatabase())
                {
                    NextCharId = -1,
                    MaxCharacterSlots = -1,
                    Name = "Guest",
                };
            }

            var accountElem = XMLModelParser.AccountModelToXML(accountModel);

            var xml = new XElement("Chars");
            xml.Add(new XAttribute("nextCharId", accountModel.NextCharId));
            xml.Add(new XAttribute("maxNumChars", accountModel.MaxCharacterSlots));

            // load character stats & currencies

            var stats = new XElement("Stats", 
                new XElement("TotalFame", 0),
                new XElement("BestCharFame", 0),
                new XElement("Fame", 0));

            //stats.Add(new XElement("ClassStats", 
            //    new XAttribute("objectType", 0x030e),
            //    new XElement("BestLevel", 0),
            //    new XElement("BestFame", 0));

            accountElem.Add(new XElement("Credits", 0));
            accountElem.Add(new XElement("FortuneToken", 0));
            accountElem.Add(stats);

            xml.Add(accountElem);

            var characters = RedisService.LoadCharacters(accountId);
            foreach(var character in characters)
            {
                var chr = XMLModelParser.CharacterModelToXML(character);
                //var pet = // todo load from db
                xml.Add(chr);
            }

            //ClassAvailabilityList
            //BeginnerPackageStatus
            //xml.Add(new XElement("Guild"));
            xml.Add(new XElement("News"));

            xml.Add(new XElement("Lat", 0.0));
            xml.Add(new XElement("Long", 0.0));

            //SalesForce

            //TOSPopup????
            //xml.Add(new XElement("TOSPopup"));

            Response.CreateXML(xml.ToString());
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