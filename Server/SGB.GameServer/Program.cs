using SGB.GameServer.Core;
using SGB.Shared;

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