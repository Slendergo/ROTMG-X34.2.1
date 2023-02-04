using System.Net;
using System.Text;

namespace SGB.GameServer.Core.IO
{
    public sealed class OutgoingPayload
    {
        public readonly byte Id;
        private readonly List<byte> Buffer = new List<byte>();
        private int Length;

        public OutgoingPayload(byte id)
        {
            Id = id;
        }

        public void WriteByte(int value)
        {
            Buffer.Add((byte)value);
            Length += sizeof(byte);
        }

        public void WriteByte(byte value)
        {
            Buffer.Add(value);
            Length += sizeof(byte);
        }

        public void WriteBoolean(bool value)
        {
            Buffer.Add((byte)(value ? 1 : 0));
            Length += sizeof(bool);
        }

        public void WriteFloat(float value)
        {
            var val = BitConverter.GetBytes(value);
            Array.Reverse(val);
            Buffer.AddRange(val);
            Length += sizeof(float);
        }

        public void WriteFloat(double value)
        {
            var val = BitConverter.GetBytes((float)value);
            Array.Reverse(val);
            Buffer.AddRange(val);
            Length += sizeof(float);
        }

        public void WriteDouble(double value)
        {
            var val = BitConverter.GetBytes(value);
            Array.Reverse(val);
            Buffer.AddRange(val);
            Length += sizeof(double);
        }

        public void WriteInt16(short value)
        {
            Buffer.AddRange(BitConverter.GetBytes(IPAddress.HostToNetworkOrder(value)));
            Length += sizeof(short);
        }

        public void WriteInt16(int value)
        {
            Buffer.AddRange(BitConverter.GetBytes(IPAddress.HostToNetworkOrder((short)value)));
            Length += sizeof(short);
        }

        public void WriteInt32(int value)
        {
            Buffer.AddRange(BitConverter.GetBytes(IPAddress.HostToNetworkOrder(value)));
            Length += sizeof(int);
        }

        public void WriteUTF16(string value)
        {
            var bytes = Encoding.UTF8.GetBytes(value);
            WriteInt16((short)bytes.Length);
            Buffer.AddRange(bytes);
            Length += bytes.Length;
        }

        public void WriteUTF32(string value)
        {
            var bytes = Encoding.UTF8.GetBytes(value);
            WriteInt32(bytes.Length);
            Buffer.AddRange(bytes);
            Length += bytes.Length;
        }

        public void WriteCompressedInt(int value)
        {
            var v = (uint)value;
            while (v >= 128)
            {
                WriteByte((byte)(v | 128));
                v >>= 7;
            }
            WriteByte((byte)v);
        }

        public byte[] GetBuffer()
        {
            // 1 bytes
            // 4 byte
            // N bytes

            if (Buffer.Count != Length + 5)
            {
                Buffer.InsertRange(0, BitConverter.GetBytes(IPAddress.HostToNetworkOrder(Length + 5)));
                Buffer.Insert(4, Id);
            }
            return Buffer.ToArray();
        }
    }
}
