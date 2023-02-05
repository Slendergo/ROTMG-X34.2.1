// Decompiled by AS3 Sorcerer 1.40
// http://www.as3sorcerer.com/

//kabam.rotmg.news.model.DefaultNewsCellVO

package kabam.rotmg.news.model{
    public class DefaultNewsCellVO extends NewsCellVO {

        public function DefaultNewsCellVO(_arg1:int){
            imageURL = "";
            linkDetail = (((_arg1 == 0)) ? "https://www.reddit.com/r/RotMG/search?sort=new&restrict_sr=on&q=flair%3AOfficial%2BDeca" : "https://goo.gl/DXwAbW");
            headline = (((_arg1 == 0)) ? "Official Deca Posts on Reddit" : "Join us on Facebook!");
            startDate = (new Date().getTime() - 0x3B9ACA00);
            endDate = (new Date().getTime() + 0x3B9ACA00);
            linkType = NewsCellLinkType.OPENS_LINK;
            priority = 999999;
            slot = _arg1;
        }

    }
}//package kabam.rotmg.news.model

