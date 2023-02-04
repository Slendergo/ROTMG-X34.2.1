using SGB.GameServer.Utils;
using System.Drawing;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace SGB.GameServer.Core.IO
{
    public sealed class Payload
    {
        public readonly byte Id;
        private byte[] PayloadBuffer;
        private int Position;

        public Payload(byte[] buffer, int offset, int length)
        {
            PayloadBuffer = new byte[length];
            Buffer.BlockCopy(buffer, offset, PayloadBuffer, 0, length);
            Id = ReadByte();
        }

        public byte ReadByte() => PayloadBuffer[Position++];

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

    public sealed class Session
    {
        public Guid Id { get; private set; }
        public Socket Socket { get; private set; }
        public bool Disconnected { get; private set; }
        public Queue<Payload> Payloads = new Queue<Payload>();

        public Session(Socket socket)
        {
            Id = Guid.NewGuid();
            Socket = socket;
        }

        public void Start()
        {
            var receiveBuffer = new byte[4096]; // 4096 should be enough for a packet
            _ = Socket.BeginReceive(receiveBuffer, 0, 4, SocketFlags.None, OnReceiveHeader, receiveBuffer);
        }

        private void OnReceiveHeader(IAsyncResult asyncResult)
        {
            try
            {
                var receiveBuffer = (byte[])asyncResult.AsyncState!;
                var receiedBytes = Socket.EndReceive(asyncResult);
                if (receiedBytes > receiveBuffer.Length || receiedBytes != 4)
                {
                    // uh oh stinky poopy
                    Stop();
                    return;
                }

                var payloadSize = IPAddress.HostToNetworkOrder(BitConverter.ToInt32(receiveBuffer, 0)) - 4; 

                // this time we offset by payload length size and start receiving the payload
                _ = Socket.BeginReceive(receiveBuffer, 4, payloadSize, SocketFlags.None, OnReceivePayload, receiveBuffer);
            }
            catch (SocketException e)
            {
                Console.WriteLine($"[OnReceiveHeader] Exception -> {e.Message} {e.StackTrace}");

                // uh oh stinky poopy
                Stop();
            }
        }

        private void OnReceivePayload(IAsyncResult asyncResult)
        {
            try
            {
                var receiveBuffer = (byte[])asyncResult.AsyncState!;
                var receivedBytes = Socket.EndReceive(asyncResult);

                if (receivedBytes > receiveBuffer.Length)
                {
                    // uh oh stinky poopy
                    // invalid packet payload size will stop overflow of buffer resizing
                    Stop();
                    return;
                }

                lock (Payloads)
                {
                    var payload = new Payload(receiveBuffer, 4, receivedBytes);
                    DebugUtils.Log(payload.Id);
                    Payloads.Enqueue(payload);
                }

                // reset receive buffer to prevent leakage
                Array.Clear(receiveBuffer, 0, receiveBuffer.Length);

                // lets start it back up
                _ = Socket.BeginReceive(receiveBuffer, 0, 4, SocketFlags.None, OnReceiveHeader, receiveBuffer);
            }
            catch (SocketException e)
            {
                Console.WriteLine($"[OnPayloadHeader] Exception -> {e.Message} {e.StackTrace}");
                // uh oh stinky poopy
                Stop();
            }
        }

        public void Send(byte[] buffer)
        {
            Socket.BeginSend(buffer, 0, buffer.Length, SocketFlags.None, OnSend, buffer.Length);
        }

        private void OnSend(IAsyncResult asyncResult)
        {
            try
            {
                var expectedLength = (int)asyncResult.AsyncState!;
                var result = Socket.EndSend(asyncResult);
                if (result != expectedLength)
                {
                    // uh oh stinky poopy.
                    Stop();
                }
            }
            catch (SocketException e)
            {
                Console.WriteLine($"[OnPayloadHeader] Exception -> {e.Message} {e.StackTrace}");
                // uh oh stinky poopy
                Stop();
            }
        }

        public void Stop()
        {
            if (Disconnected)
                return;
            Disconnected = true;
            Socket.Close();
        }
    }
}
