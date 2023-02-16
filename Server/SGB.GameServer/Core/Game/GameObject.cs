namespace SGB.GameServer.Core.Game
{
    public sealed class GameObject
    {
        public int Id;
        public int ObjectType;
        public double X;
        public double Y;

        public bool Update(double dt)
        {
            return false;
        }
    }
}
