using SGB.GameServer.Core;

namespace SGB.GameServer
{
    public sealed class Program
    {
        public static void Main(string[] args)
        {
            using var application = new Application(2050);
            application.Run();
        }
    }
}