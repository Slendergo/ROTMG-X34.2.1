using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using SGB.API.Database;
using System;
using System.Runtime.Versioning;
using System.Text;

namespace SGB.API
{
    public sealed class CoreService 
    {
        private readonly IWebHostEnvironment WebHostingEnvronment;

        public string ResourcePath { get; private set; }

        public CoreService(IConfiguration configuration, IWebHostEnvironment webHostingEnvronment)
        {
            WebHostingEnvronment = webHostingEnvronment;

            var applicationName = WebHostingEnvronment.ApplicationName;
            var fileProvider = WebHostingEnvronment.ContentRootFileProvider;
            var wwwPath = WebHostingEnvronment.WebRootPath;
            var contentPath = WebHostingEnvronment.ContentRootPath;

            var databaseIndex = Convert.ToInt32(configuration.GetConnectionString("index"));
            var host = configuration.GetConnectionString("host");
            var port = configuration.GetConnectionString("port");
            var password = configuration.GetConnectionString("auth");

            var connectionStr = new StringBuilder();
            _ = connectionStr.Append($"{host}:{port}");
            if (!string.IsNullOrWhiteSpace(password))
                _ = connectionStr.Append($",password={password}");
            _ = connectionStr.Append($",syncTimeout=5000");
            _ = connectionStr.Append($",asyncTimeout=5000");
            var configurationString = connectionStr.ToString();
            
            RedisService.Configure(configurationString, databaseIndex);

            ResourcePath = $"{Environment.CurrentDirectory}/{configuration.GetConnectionString("resourcesPath")}";

            // resources might not be needed to do stuff?
            //Resources.Configure(resourcePath);
        }

        public bool IsProduction()
        {
#if DEBUG
            return false;
#else
            return true;
#endif
        }
    }
}