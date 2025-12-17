

Stimulate a deep link with adb 

https://hader-pharm/product/parapharma/019a452f-3c3a-770d-8cc3-8321bd5d0042#Intent;scheme=hader;package=com.hader.pharma;end

adb shell am start -a android.intent.action.VIEW -d "hader://hader-pharm/product/parapharma/019a452f-3c3a-770d-8cc3-8321bd5d0042" com.hader.pharma

adb shell am start -a android.intent.action.VIEW -d "https://hader-pharm.com/product/parapharma/019a452f-3c3a-770d-8cc3-8321bd5d0042" com.hader.pharma


./adb shell am start -a android.intent.action.VIEW -d "https://hader-pharm.com/order?orderId=0197df45-1deb-76d8-be04-807828e3a1c0" com.hader.pharma

./adb shell am start -a android.intent.action.VIEW -d "https://hader-pharm/signup?token=6fa999ad-fd38-416f-a938-c4bd93e29170.1860404841.dad6f60bd0b9f5dbb07567236193d433c22a9fe6327213257a0b910858c99c48" com.hader.pharma



