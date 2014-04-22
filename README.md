AdmodAds
========

谷歌ADmodANE（iOS）
## 谷歌ADmodANE
* 官方SDK地址：[传送门](http://www.admod.com)
* IOS对应版本：`iOS SDK 6.8`
* 包含`banner`,`interstatial`

		

## iOS版特别说明



* iOS版只需要调用两个函数即可

		//iOS func
		public function AdmodBanner(admodAppKeyID:String):String{
			
			if(extContext ){
				return extContext.call(ADMOD_FUNCTION_BANNER,admodAppKeyID
				) as String;
			}
			return "call AdmodBanner failed";
		} 
		
		public function AdmodInterStatial(admodAppKeyID:String):String{
			
			if(extContext ){
				return extContext.call(ADMOD_FUNCTION_INTERSTITIAL,admodAppKeyID) as String;
			}
			return "call AdmodInterStatial failed";
		} 
							 
		
* 广告ID注意修改为自身应该的`key`					 
		
## 作者

* [platformANEs](https://github.com/platformanes)由 [zrong](http://zengrong.net) 和 [rect](http://www.shadowkong.com/) 共同发起并完成。
