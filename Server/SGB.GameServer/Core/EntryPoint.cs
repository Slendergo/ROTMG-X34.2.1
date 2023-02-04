using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Net.NetworkInformation;
using System.Reflection.Metadata;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;
using SGB.GameServer.Core.IO;
using SGB.GameServer.Utils;
using static System.Formats.Asn1.AsnWriter;
using static System.Net.Mime.MediaTypeNames;

namespace SGB.GameServer.Core
{
    public sealed class Application : IDisposable
    {
        public readonly SessionManager SessionManager;
        public readonly SessionListener SessionListener;

        public Application()
        {
            SessionManager = new SessionManager(this);
            SessionListener = new SessionListener(this, 2050);
        }

        public void Run()
        {
            SessionListener.Start();

            // main thread will be used to handle restarting the server automatically

            var last = Stopwatch.GetTimestamp(); 
            while (true)
            {
                var now = Stopwatch.GetTimestamp();
                var dt = Stopwatch.GetElapsedTime(last).Milliseconds;

                if (dt >= 200)
                {
                    HandleSessions();
                    HandleInstances(dt * 0.001);
                    last = now;
                }
            }

        }

        private void HandleSessions()
        {
            foreach(var session in SessionManager.Sessions.Values)
                while(session.Payloads.Count > 0)
                {
                    var payload = session.Payloads.Dequeue();
                    try
                    {
                        HandleState(session, payload);
                    }
                    catch (Exception e)
                    {
                        DebugUtils.Log($"HandleSessions: {payload.Id} Error: {e.Message} {e.StackTrace}");
                        throw;
                    }
                }
        }

        private void HandleState(Session session, IncomingPayload payload)
        {
            switch (payload.Id)
            {
                case HELLO:
                    HandleHello(session, payload);
                    break;

                case LOAD:
                    HandleLoad(session, payload);
                    break;

                case CREATE:
                    HandleCreate(session, payload);
                    break;

                default:
                    DebugUtils.Log($"Unknown Payload Id: {payload.Id}");
                    break;
            }
        }

        private void HandleInstances(double dt)
        {
            //DebugUtils.Log(dt);
        }

        private void HandleHello(Session session, IncomingPayload payload)
        {
            var outgoingPayload = new OutgoingPayload(MAPINFO);
            outgoingPayload.WriteInt32(32);
            outgoingPayload.WriteInt32(32);
            outgoingPayload.WriteUTF16("Nexus");
            outgoingPayload.WriteUTF16("Nexus");
            outgoingPayload.WriteUTF16("Nexus");
            outgoingPayload.WriteInt32(0);
            outgoingPayload.WriteInt32(0);
            outgoingPayload.WriteInt32(0);
            outgoingPayload.WriteBoolean(false);
            outgoingPayload.WriteBoolean(false);
            outgoingPayload.WriteInt16(85);
            outgoingPayload.WriteUTF16("connectionGuid_");
            outgoingPayload.WriteInt32(0);
            outgoingPayload.WriteInt16(0);
            outgoingPayload.WriteInt16(0);
            session.Send(outgoingPayload.GetBuffer());
        }

        private void HandleLoad(Session session, IncomingPayload payload)
        {
            var characterId = payload.ReadInt32();
            var isFromArena = payload.ReadBoolean();

            var outgoingPayload = new OutgoingPayload(CREATE_SUCCESS);
            outgoingPayload.WriteInt32(characterId);
            outgoingPayload.WriteInt32(0);
            session.Send(outgoingPayload.GetBuffer());
        }

        private void HandleCreate(Session session, IncomingPayload payload)
        {
            var classType = payload.ReadInt16();
            var skinType = payload.ReadInt16();

            var outgoingPayload = new OutgoingPayload(CREATE_SUCCESS);
            outgoingPayload.WriteInt32(0);
            outgoingPayload.WriteInt32(0);
            session.Send(outgoingPayload.GetBuffer());
        }

        public const int FAILURE = 0;
        public const int CREATE_SUCCESS = 101;
        public const int CREATE = 61;
        public const int PLAYERSHOOT = 30;
        public const int MOVE = 42;
        public const int PLAYERTEXT = 10;
        public const int TEXT = 44;
        public const int SERVERPLAYERSHOOT = 12;
        public const int DAMAGE = 75;
        public const int UPDATE = 62;
        public const int UPDATEACK = 81;
        public const int NOTIFICATION = 67;
        public const int NEWTICK = 9;
        public const int INVSWAP = 19;
        public const int USEITEM = 11;
        public const int SHOWEFFECT = 13;
        public const int HELLO = 1;
        public const int GOTO = 18;
        public const int INVDROP = 55;
        public const int INVRESULT = 95;
        public const int RECONNECT = 45;
        public const int PING = 8;
        public const int PONG = 31;
        public const int MAPINFO = 92;
        public const int LOAD = 57;
        public const int PIC = 83;
        public const int SETCONDITION = 60;
        public const int TELEPORT = 74;
        public const int USEPORTAL = 47;
        public const int DEATH = 46;
        public const int BUY = 85;
        public const int BUYRESULT = 22;
        public const int AOE = 64;
        public const int GROUNDDAMAGE = 103;
        public const int PLAYERHIT = 90;
        public const int ENEMYHIT = 25;
        public const int AOEACK = 89;
        public const int SHOOTACK = 100;
        public const int OTHERHIT = 20;
        public const int SQUAREHIT = 40;
        public const int GOTOACK = 65;
        public const int EDITACCOUNTLIST = 27;
        public const int ACCOUNTLIST = 99;
        public const int QUESTOBJID = 82;
        public const int CHOOSENAME = 97;
        public const int NAMERESULT = 21;
        public const int CREATEGUILD = 59;
        public const int GUILDRESULT = 26;
        public const int GUILDREMOVE = 15;
        public const int GUILDINVITE = 104;
        public const int ALLYSHOOT = 49;
        public const int ENEMYSHOOT = 35;
        public const int REQUESTTRADE = 5;
        public const int TRADEREQUESTED = 88;
        public const int TRADESTART = 86;
        public const int CHANGETRADE = 56;
        public const int TRADECHANGED = 28;
        public const int ACCEPTTRADE = 36;
        public const int CANCELTRADE = 91;
        public const int TRADEDONE = 34;
        public const int TRADEACCEPTED = 14;
        public const int CLIENTSTAT = 69;
        public const int CHECKCREDITS = 102;
        public const int ESCAPE = 105;
        public const int FILE = 106;
        public const int INVITEDTOGUILD = 77;
        public const int JOINGUILD = 7;
        public const int CHANGEGUILDRANK = 37;
        public const int PLAYSOUND = 38;
        public const int GLOBAL_NOTIFICATION = 66;
        public const int RESKIN = 51;
        public const int PETUPGRADEREQUEST = 16;
        public const int ACTIVE_PET_UPDATE_REQUEST = 24;
        public const int ACTIVEPETUPDATE = 76;
        public const int NEW_ABILITY = 41;
        public const int PETYARDUPDATE = 78;
        public const int EVOLVE_PET = 87;
        public const int DELETE_PET = 4;
        public const int HATCH_PET = 23;
        public const int ENTER_ARENA = 17;
        public const int IMMINENT_ARENA_WAVE = 50;
        public const int ARENA_DEATH = 68;
        public const int ACCEPT_ARENA_DEATH = 80;
        public const int VERIFY_EMAIL = 39;
        public const int RESKIN_UNLOCK = 107;
        public const int PASSWORD_PROMPT = 79;
        public const int QUEST_FETCH_ASK = 98;
        public const int QUEST_REDEEM = 58;
        public const int QUEST_FETCH_RESPONSE = 6;
        public const int QUEST_REDEEM_RESPONSE = 96;
        public const int PET_CHANGE_FORM_MSG = 53;
        public const int KEY_INFO_REQUEST = 94;
        public const int KEY_INFO_RESPONSE = 63;
        public const int CLAIM_LOGIN_REWARD_MSG = 3;
        public const int LOGIN_REWARD_MSG = 93;
        public const int QUEST_ROOM_MSG = 48;
        public const int PET_CHANGE_SKIN_MSG = 33;
        public const int REALM_HERO_LEFT_MSG = 84;
        public const int RESET_DAILY_QUESTS = 52;

        // cleanup
        public void Dispose()
        {
            SessionManager.Dispose();
            SessionListener.Dispose();
        }
    }
}
