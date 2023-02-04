using System.Net;
using System.Text;

namespace SGB.GameServer.Core.IO
{
    public sealed class IncomingPayload
    {
        public readonly byte Id;
        private byte[] PayloadBuffer;
        private int Position;

        public IncomingPayload(byte[] buffer, int offset, int length)
        {
            PayloadBuffer = new byte[length];
            Buffer.BlockCopy(buffer, offset, PayloadBuffer, 0, length);
            Id = ReadByte();
        }

        public byte ReadByte() => PayloadBuffer[Position++];
        public bool ReadBoolean() => PayloadBuffer[Position++] == 1;

        public float ReadFloat()
        {
            Array.Reverse(PayloadBuffer, Position, sizeof(float));
            var value = BitConverter.ToSingle(PayloadBuffer, Position);
            Position += sizeof(float);
            return value;
        }

        public double ReadDouble()
        {
            Array.Reverse(PayloadBuffer, Position, sizeof(double));
            var value = BitConverter.ToDouble(PayloadBuffer, Position);
            Position += sizeof(double);
            return value;
        }

        public short ReadInt16()
        {
            var value = IPAddress.NetworkToHostOrder(BitConverter.ToInt16(PayloadBuffer, Position));
            Position += sizeof(short);
            return value;
        }

        public int ReadInt32()
        {
            var value = IPAddress.NetworkToHostOrder(BitConverter.ToInt32(PayloadBuffer, Position));
            Position += sizeof(int);
            return value;
        }

        public string ReadUTF16()
        {
            var size = ReadInt16();
            if (size == 0)
                return "";
            var value = Encoding.UTF8.GetString(PayloadBuffer, Position, size);
            Position += size;
            return value;
        }

        public string ReadUTF32()
        {
            var size = ReadInt32();
            if (size == 0)
                return "";
            var value = Encoding.UTF8.GetString(PayloadBuffer, Position, size);
            Position += size;
            return value;
        }
    }
}
