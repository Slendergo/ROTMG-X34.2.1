using Microsoft.AspNetCore.Mvc;
using SGB.API.Database;
using System;
using System.Collections.Generic;
using System.Xml.Linq;

namespace SGB.API.Controllers
{
    [ApiController]
    [Route("dailyLogin")]
    public class DailyLoginController : ControllerBase
    {
        private readonly CoreService _core;

        public DailyLoginController(CoreService core)
        {
            _core = core;
        }

        [HttpPost("fetchCalendar")]
        public void FetchCalendar([FromForm] string guid, [FromForm] string password, [FromForm] bool isChallenger)
        {
            // todo remove placeholder

            Response.CreateXML(@"<LoginRewards serverTime=""1585413664.54"" conCurDay=""3"" nonconCurDay=""5"">
   <NonConsecutive days=""5"">
      <Login>
         <Days>24</Days>
         <ItemId quantity=""1"">3266</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>25</Days>
         <ItemId quantity=""1"">24738</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>26</Days>
         <ItemId quantity=""1"">3271</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>27</Days>
         <ItemId quantity=""1"">8647</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>20</Days>
         <ItemId quantity=""1"">3470</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>21</Days>
         <ItemId quantity=""1"">8646</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>22</Days>
         <ItemId quantity=""1"">18516</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>23</Days>
         <ItemId quantity=""1"">8971</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>28</Days>
         <ItemId quantity=""1"">18522</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>29</Days>
         <ItemId quantity=""1"">8972</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>1</Days>
         <ItemId quantity=""1"">5072</ItemId>
         <Gold>0</Gold>
         <Claimed />
      </Login>
      <Login>
         <Days>3</Days>
         <ItemId quantity=""1"">8643</ItemId>
         <Gold>0</Gold>
         <Claimed />
      </Login>
      <Login>
         <Days>2</Days>
         <ItemId quantity=""1"">316</ItemId>
         <Gold>0</Gold>
         <Claimed />
      </Login>
      <Login>
         <Days>5</Days>
         <ItemId quantity=""1"">3269</ItemId>
         <Gold>0</Gold>
         <key>ahVzfnJlYWxtb2Z0aGVtYWRnb2RocmRyLwsSB0FjY291bnQYgIDA_MKg3woMCxIORGFpbHlMb2dpbkRhdGEYgIDolb_a3goM</key>
      </Login>
      <Login>
         <Days>4</Days>
         <ItemId quantity=""5"">5094</ItemId>
         <Gold>0</Gold>
         <key>ahVzfnJlYWxtb2Z0aGVtYWRnb2RocmRyLwsSB0FjY291bnQYgIDA_MKg3woMCxIORGFpbHlMb2dpbkRhdGEYgIDojYjKqwsM</key>
      </Login>
      <Login>
         <Days>7</Days>
         <ItemId quantity=""1"">5073</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>6</Days>
         <ItemId quantity=""1"">5074</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>9</Days>
         <ItemId quantity=""1"">8644</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>8</Days>
         <ItemId quantity=""1"">3180</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>11</Days>
         <ItemId quantity=""1"">24737</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>10</Days>
         <ItemId quantity=""1"">3176</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>13</Days>
         <ItemId quantity=""2"">3180</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>12</Days>
         <ItemId quantity=""1"">3268</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>15</Days>
         <ItemId quantity=""1"">8645</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>14</Days>
         <ItemId quantity=""1"">3468</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>17</Days>
         <ItemId quantity=""1"">3177</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>16</Days>
         <ItemId quantity=""1"">8970</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>19</Days>
         <ItemId quantity=""1"">3272</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>18</Days>
         <ItemId quantity=""1"">6731</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>31</Days>
         <ItemId quantity=""1"">29652</ItemId>
         <Gold>0</Gold>
      </Login>
      <Login>
         <Days>30</Days>
         <ItemId quantity=""1"">9136</ItemId>
         <Gold>0</Gold>
      </Login>
   </NonConsecutive>
   <Consecutive days=""3"" />
   <Unlockable days=""5"" />
</LoginRewards>");
        }
    }
}