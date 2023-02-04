using SGB.GameServer.Core;
using System.ComponentModel.DataAnnotations;
using System.Diagnostics;

namespace SGB.GameServer
{
    public sealed class Program
    {
        public static void Main(string[] args)
        {
            using var entryPoint = new Application();
            entryPoint.Run();
        }
    }
}