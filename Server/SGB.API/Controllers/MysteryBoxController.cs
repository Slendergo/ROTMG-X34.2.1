using Microsoft.AspNetCore.Mvc;
using SGB.API.Database;
using System;
using System.Collections.Generic;
using System.Xml.Linq;

namespace SGB.API.Controllers
{
    [ApiController]
    [Route("mysterybox")]
    public class MysteryBoxController : ControllerBase
    {
        private readonly CoreService _core;

        public MysteryBoxController(CoreService core)
        {
            _core = core;
        }

        [HttpPost("getBoxes")]
        public void GetBoxes([FromForm] string language, [FromForm] string version)
        {
            // todo remove placeholder

            Response.CreateXML(@"<MiniGames version=""1585411548.536421"">
   <MysteryBox id=""1414"" title=""Ninja ST Box"" weight=""0"">
      <Description />
      <Contents>7757,7768,7759,7760,24256,8866,8866,8866;7757,7768,7759,7760,8866,8866;7757,7768,7759,7760,24256;8866,8866;24256;8866;7757;7768;7759;7760;8646;8645;8644;8643</Contents>
      <Price amount=""199"" currency=""0"" />
      <Image />
      <Icon />
      <StartTime>2020-03-26 08:00:01</StartTime>
      <Left>-1</Left>
      <Total>-1</Total>
      <MaxPurchase>-1</MaxPurchase>
      <PurchaseLeft>-1</PurchaseLeft>
      <Tags />
      <Slot>11</Slot>
      <Jackpots>7757,7768,7759,7760,24256,8866,8866,8866|7757,7768,7759,7760,8866,8866|7757,7768,7759,7760,24256</Jackpots>
      <DisplayedItems>7757,7768,7759,7760,24256</DisplayedItems>
      <EndTime>2020-03-30 08:00:00</EndTime>
      <Rolls>1</Rolls>
      <Sale price=""-1"" currency=""0"" />
   </MysteryBox>
   <MysteryBox id=""1482"" title=""Hit-or-Miss Loot Drop 2"" weight=""0"">
      <Description />
      <Contents>3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177;3177,3177,3177,3177,3177;3177,3177</Contents>
      <Price amount=""199"" currency=""0"" />
      <Image />
      <Icon />
      <StartTime>2020-03-26 12:00:00</StartTime>
      <Left>-1</Left>
      <Total>-1</Total>
      <MaxPurchase>-1</MaxPurchase>
      <PurchaseLeft>-1</PurchaseLeft>
      <Tags />
      <Slot>6</Slot>
      <Jackpots>3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177,3177</Jackpots>
      <DisplayedItems>3177</DisplayedItems>
      <EndTime>2020-03-31 12:00:00</EndTime>
      <Rolls>1</Rolls>
      <Sale price=""-1"" currency=""0"" />
   </MysteryBox>
   <MysteryBox id=""1483"" title=""Golden Clover Box"" weight=""0"">
      <Description />
      <Contents>29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652;3266,3266,3266,3266,3266,3266,3266,3266,3266,3266;3266,3266,3266,3266,3266</Contents>
      <Price amount=""499"" currency=""0"" />
      <Image />
      <Icon />
      <StartTime>2020-03-26 12:00:00</StartTime>
      <Left>-1</Left>
      <Total>-1</Total>
      <MaxPurchase>-1</MaxPurchase>
      <PurchaseLeft>-1</PurchaseLeft>
      <Tags />
      <Slot>5</Slot>
      <Jackpots>29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652,29652</Jackpots>
      <DisplayedItems>29652,3266</DisplayedItems>
      <EndTime>2020-03-31 12:00:00</EndTime>
      <Rolls>1</Rolls>
      <Sale price=""-1"" currency=""0"" />
   </MysteryBox>
   <MysteryBox id=""1454"" title=""March Legacy 13"" weight=""0"">
      <Description />
      <Contents>19570,9151,32673,9175;12055,12055,12055,12055;12055,12055;12055;12045;3276;810;811;12040;12039;12038;12037;12036</Contents>
      <Price amount=""169"" currency=""0"" />
      <Image />
      <Icon />
      <StartTime>2020-03-23 08:00:01</StartTime>
      <Left>-1</Left>
      <Total>-1</Total>
      <MaxPurchase>-1</MaxPurchase>
      <PurchaseLeft>-1</PurchaseLeft>
      <Tags />
      <Slot>7</Slot>
      <Jackpots>19570,9151,32673,9175</Jackpots>
      <DisplayedItems>19570,9151,32673,9175</DisplayedItems>
      <EndTime>2020-03-30 08:00:00</EndTime>
      <Rolls>1</Rolls>
      <Sale price=""-1"" currency=""0"" />
   </MysteryBox>
   <MysteryBox id=""1455"" title=""March Legacy 14"" weight=""0"">
      <Description />
      <Contents>6878,6890,6117,14100;12055,12055,12055,12055;12055,12055;12055;12045;3276;810;811;12040;12039;12038;12037;12036</Contents>
      <Price amount=""169"" currency=""0"" />
      <Image />
      <Icon />
      <StartTime>2020-03-23 08:00:01</StartTime>
      <Left>-1</Left>
      <Total>-1</Total>
      <MaxPurchase>-1</MaxPurchase>
      <PurchaseLeft>-1</PurchaseLeft>
      <Tags />
      <Slot>8</Slot>
      <Jackpots>6878,6890,6117,14100</Jackpots>
      <DisplayedItems>6878,6890,6117,14100</DisplayedItems>
      <EndTime>2020-03-30 08:00:00</EndTime>
      <Rolls>1</Rolls>
      <Sale price=""-1"" currency=""0"" />
   </MysteryBox>
   <MysteryBox id=""1456"" title=""March Legacy 15"" weight=""0"">
      <Description />
      <Contents>9154,9160,9317,14097;12055,12055,12055,12055;12055,12055;12055;12045;3276;810;811;12040;12039;12038;12037;12036</Contents>
      <Price amount=""169"" currency=""0"" />
      <Image />
      <Icon />
      <StartTime>2020-03-26 08:00:01</StartTime>
      <Left>-1</Left>
      <Total>-1</Total>
      <MaxPurchase>-1</MaxPurchase>
      <PurchaseLeft>-1</PurchaseLeft>
      <Tags />
      <Slot>9</Slot>
      <Jackpots>9154,9160,9317,14097</Jackpots>
      <DisplayedItems>9154,9160,9317,14097</DisplayedItems>
      <EndTime>2020-04-02 08:00:00</EndTime>
      <Rolls>1</Rolls>
      <Sale price=""-1"" currency=""0"" />
   </MysteryBox>
   <MysteryBox id=""1457"" title=""March Legacy 16"" weight=""0"">
      <Description />
      <Contents>24225,10983,24722,14103;12055,12055,12055,12055;12055,12055;12055;12045;3276;810;811;12040;12039;12038;12037;12036</Contents>
      <Price amount=""169"" currency=""0"" />
      <Image />
      <Icon />
      <StartTime>2020-03-26 08:00:01</StartTime>
      <Left>-1</Left>
      <Total>-1</Total>
      <MaxPurchase>-1</MaxPurchase>
      <PurchaseLeft>-1</PurchaseLeft>
      <Tags />
      <Slot>10</Slot>
      <Jackpots>24225,10983,24722,14103</Jackpots>
      <DisplayedItems>24225,10983,24722,14103</DisplayedItems>
      <EndTime>2020-04-02 08:00:00</EndTime>
      <Rolls>1</Rolls>
      <Sale price=""-1"" currency=""0"" />
   </MysteryBox>
   <MysteryBox id=""1426"" title=""Tamed Beasts Box"" weight=""0"">
      <Description />
      <Contents>10176,30158,6511,3276,810;10176,30158,3276,810;10176,6511,3276,810;10176;30158;19210;19200;3276;810;811;19195;19194;19193;19192;19191</Contents>
      <Price amount=""169"" currency=""0"" />
      <Image />
      <Icon />
      <StartTime>2020-03-26 08:00:00</StartTime>
      <Left>-1</Left>
      <Total>-1</Total>
      <MaxPurchase>-1</MaxPurchase>
      <PurchaseLeft>-1</PurchaseLeft>
      <Tags />
      <Slot>3</Slot>
      <Jackpots>10176,30158,6511,3276,810|10176,30158,3276,810|10176,6511,3276,810</Jackpots>
      <DisplayedItems>10176,30158,6511</DisplayedItems>
      <EndTime>2020-03-30 08:00:00</EndTime>
      <Rolls>1</Rolls>
      <Sale price=""-1"" currency=""0"" />
   </MysteryBox>
   <MysteryBox id=""1422"" title=""Assassin ST Box"" weight=""0"">
      <Description />
      <Contents>3032,3033,3034,3035,1306,8866,8866,8866;3032,3033,3034,3035,8866,8866;3032,3033,3034,3035,1306;8866,8866;1306;8866;3032;3033;3034;3035;8646;8645;8644;8643</Contents>
      <Price amount=""199"" currency=""0"" />
      <Image />
      <Icon />
      <StartTime>2020-03-28 08:00:01</StartTime>
      <Left>-1</Left>
      <Total>-1</Total>
      <MaxPurchase>-1</MaxPurchase>
      <PurchaseLeft>-1</PurchaseLeft>
      <Tags />
      <Slot>12</Slot>
      <Jackpots>3032,3033,3034,3035,1306,8866,8866,8866|3032,3033,3034,3035,8866,8866|3032,3033,3034,3035,1306</Jackpots>
      <DisplayedItems>3032,3033,3034,3035,1306</DisplayedItems>
      <EndTime>2020-04-02 08:00:00</EndTime>
      <Rolls>1</Rolls>
      <Sale price=""-1"" currency=""0"" />
   </MysteryBox>
   <MysteryBox id=""1401"" title=""QoL Box"" weight=""0"">
      <Description />
      <Contents>3180,3266,3176,3177,316,316,5072,5072,18522,18516;3266,3176,3177,3180;18522;18516;3180;3177;3266;3176</Contents>
      <Price amount=""69"" currency=""0"" />
      <Image />
      <Icon />
      <StartTime>2020-03-01 08:00:01</StartTime>
      <Left>-1</Left>
      <Total>-1</Total>
      <MaxPurchase>-1</MaxPurchase>
      <PurchaseLeft>-1</PurchaseLeft>
      <Tags />
      <Slot>16</Slot>
      <Jackpots>3180,3266,3176,3177,316,316,5072,5072,18522,18516|3266,3176,3177,3180</Jackpots>
      <DisplayedItems>3180,3266,18522,18516</DisplayedItems>
      <EndTime>2020-04-01 08:00:00</EndTime>
      <Rolls>1</Rolls>
      <Sale price=""-1"" currency=""0"" />
   </MysteryBox>
   <MysteryBox id=""1433"" title=""War STory Box II"" weight=""0"">
      <Description />
      <Contents>25802,25802,25802,25802,25802,25802,25802,25802,25802,25802,25801,25801,25801,25801,25801,25801,25801,25801,25801,25801,25800,25800,25800,25800,25800,25800,25800,25800,25800,25800;25802,25802,25802,25802,25802,25801,25801,25801,25801,25801,25800,25800,25800,25800,25800;25802,25802,25802,25801,25801,25801,25800,25800,25800;25802,25802,25801,25801,25800,25800;25802,25801,25800;25802;25801;25800;25628,25628,25628,25628,25628;25628,25628;25628</Contents>
      <Price amount=""119"" currency=""0"" />
      <Image />
      <Icon />
      <StartTime>2020-03-27 08:00:00</StartTime>
      <Left>-1</Left>
      <Total>-1</Total>
      <MaxPurchase>-1</MaxPurchase>
      <PurchaseLeft>-1</PurchaseLeft>
      <Tags />
      <Slot>1</Slot>
      <Jackpots>25802,25802,25802,25802,25802,25802,25802,25802,25802,25802,25801,25801,25801,25801,25801,25801,25801,25801,25801,25801,25800,25800,25800,25800,25800,25800,25800,25800,25800,25800|25802,25802,25802,25802,25802,25801,25801,25801,25801,25801,25800,25800,25800,25800,25800|25802,25802,25802,25801,25801,25801,25800,25800,25800</Jackpots>
      <DisplayedItems>25802,25801,25800</DisplayedItems>
      <EndTime>2020-03-30 08:00:00</EndTime>
      <Rolls>1</Rolls>
      <Sale price=""-1"" currency=""0"" />
   </MysteryBox>
   <MysteryBox id=""1402"" title=""Key Box"" weight=""0"">
      <Description />
      <Contents>8972,8972,8972,8972,8972,8972,8972,8972,8972,8972,8971,8971,8971,8971,8971,8971,8971,8971,8971,8971;8972,8972,8972,8972,8972,8972,8972,8972,8971,8971,8971,8971,8971,8971,8971,8971;8972,8972,8972,8972,8972,8971,8971,8971,8971,8971;8972,8972,8972,8971,8971,8971;8972,8972,8971,8971;8972,8971;8972;8971,8971</Contents>
      <Price amount=""99"" currency=""0"" />
      <Image />
      <Icon />
      <StartTime>2020-03-01 08:00:01</StartTime>
      <Left>-1</Left>
      <Total>-1</Total>
      <MaxPurchase>-1</MaxPurchase>
      <PurchaseLeft>-1</PurchaseLeft>
      <Tags />
      <Slot>15</Slot>
      <Jackpots>8972,8972,8972,8972,8972,8972,8972,8972,8972,8972,8971,8971,8971,8971,8971,8971,8971,8971,8971,8971|8972,8972,8972,8972,8972,8972,8972,8972,8971,8971,8971,8971,8971,8971,8971,8971|8972,8972,8972,8972,8972,8971,8971,8971,8971,8971</Jackpots>
      <DisplayedItems>8972,8971</DisplayedItems>
      <EndTime>2020-04-01 08:00:00</EndTime>
      <Rolls>1</Rolls>
      <Sale price=""-1"" currency=""0"" />
   </MysteryBox>
   <MysteryBox id=""1403"" title=""Super Ambrosia Box II"" weight=""0"">
      <Description />
      <Contents>3276,3276,3276,3276,3276,3276,3276,3276,3276,3276;3276,3276,3276,3276,3276;3276,3276,3276,3276;3276,3276,3276;3276,3276;3276;3271;3272;3274</Contents>
      <Price amount=""199"" currency=""0"" />
      <Image />
      <Icon />
      <StartTime>2020-03-01 08:00:01</StartTime>
      <Left>-1</Left>
      <Total>-1</Total>
      <MaxPurchase>-1</MaxPurchase>
      <PurchaseLeft>-1</PurchaseLeft>
      <Tags />
      <Slot>17</Slot>
      <Jackpots>3276,3276,3276,3276,3276,3276,3276,3276,3276,3276</Jackpots>
      <DisplayedItems>3276</DisplayedItems>
      <EndTime>2020-04-01 08:00:00</EndTime>
      <Rolls>1</Rolls>
      <Sale price=""-1"" currency=""0"" />
   </MysteryBox>
</MiniGames>");
        }
    }
}