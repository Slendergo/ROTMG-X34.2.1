using Microsoft.AspNetCore.Mvc;
using SGB.API.Database;
using System;
using System.Collections.Generic;

namespace SGB.API.Controllers
{
    [ApiController]
    [Route("app")]
    public class AppController : ControllerBase
    {
        private readonly CoreService _core;
        private readonly Dictionary<string, byte[]> FileContentsCache = new Dictionary<string, byte[]>(StringComparer.InvariantCultureIgnoreCase);

        public AppController(CoreService core)
        {
            _core = core;
        }

        [HttpPost("getLanguageStrings")]
        public void LanguageStrings([FromForm] string languageType)
        {
            var path = $"{_core.ResourcePath}/languages/{languageType}.json";
            if(!System.IO.File.Exists(path))
                path = $"{_core.ResourcePath}/languages/en.json";
            
            if (!FileContentsCache.TryGetValue(languageType, out var data))
                data = System.IO.File.ReadAllBytes(path);
            Response.CreateBytes(data);
        }

        [HttpPost("init")]
        public void Init()
        {
            var path = $"{_core.ResourcePath}/init.xml";
            ResponseHelper.CreateBytes(Response, System.IO.File.ReadAllBytes(path));
        }

        [HttpPost("globalNews")]
        public void GlobalNews()
        {
            var path = $"{_core.ResourcePath}/globalNews.json";
            ResponseHelper.CreateBytes(Response, System.IO.File.ReadAllBytes(path));
        }
    }
}