using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.FileProviders;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using System;
using System.Net;
using System.Security.Cryptography;
using System.Text;

namespace SGB.API
{
    public sealed class Program
    {
        public static void Main(string[] args)
        {
            var builder = WebApplication.CreateBuilder(args);

            var service = builder.Services;

            // Add services to the container.

            service.AddSingleton<CoreService>();
            service.AddControllers();

#if DEBUG
            service.AddEndpointsApiExplorer();
            service.AddSwaggerGen();
#endif

            var app = builder.Build();

            var core = app.Services.GetService<CoreService>();

            var config = app.Services.GetService<IConfiguration>();
            var address = config.GetConnectionString("BindURLAddress");
            var port = config.GetConnectionString("BindURLPort");

            app.Urls.Clear();
            app.Urls.Add($"http://{address}:{port}");

            if (!core.IsProduction())
            {
                app.UseDeveloperExceptionPage();
                app.UseSwagger();
                app.UseSwaggerUI();
            }

            //app.UseStaticFiles(new StaticFileOptions()
            //{
            //    FileProvider = new PhysicalFileProvider($"{resourcePath}/web/sfx"),
            //    RequestPath = "/sfx"
            //});

            //app.UseStaticFiles(new StaticFileOptions()
            //{
            //    FileProvider = new PhysicalFileProvider($"{resourcePath}/web/music"),
            //    RequestPath = "/music"
            //});

            // we dont use https :( pservers bad

            //app.UseHttpsRedirection();
            app.UseRouting();
            app.UseAuthorization();
            app.MapControllers();

#if DEBUG
            // middleware to add request logging - could use ILogger but im lazy
            app.Use(async (context, next) =>
            {
                Console.WriteLine($"Request: '{context.Request.Path}' from: {context.Connection.RemoteIpAddress}");
                await next();
            });
#endif

            app.Run();
        }
    }
}