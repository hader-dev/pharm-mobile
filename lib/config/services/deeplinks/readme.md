

Stimulate a deep link with adb 

https://hader-pharm/product/parapharma/019a452f-3c3a-770d-8cc3-8321bd5d0042#Intent;scheme=hader;package=com.hader.pharma;end

adb shell am start -a android.intent.action.VIEW -d "hader://hader-pharm/product/parapharma/019a452f-3c3a-770d-8cc3-8321bd5d0042" com.hader.pharma

adb shell am start -a android.intent.action.VIEW -d "https://hader-pharm.com/product/parapharma/019a452f-3c3a-770d-8cc3-8321bd5d0042" com.hader.pharma


adb shell am start -a android.intent.action.VIEW -d "https://hader-pharm.com/order?orderId=0197df45-1deb-76d8-be04-807828e3a1c0" com.hader.pharma

