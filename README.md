# miniCrashReporter
市面上很多現成的上報工具，接起來很方便，但若要客製訊息則會受到一定程度的局限性，例如crash當下想列出視圖樹，或者想拋出客製化的Assert則較難用現成的工具完美達成，因此了解上報工具大致的實現方案或者說留下一條為自己客製訊息的知識點也是不錯的。

但注意，由於crash的捕獲原理是一種訊息傳遞的過程，因此如果多個工具共用，會有很高的機率無法捕獲全部的訊息，除非確認所有工具在捕獲訊息後都會再拋出訊息，這個Demo只是提供一個基礎知識以及思路。

## Crash
crash一般分两种
OC層的錯誤，也就是可捕获的signal，以及其他多半會被定義成SIGART的其他Exception，我们通称abort，當然還會有少量完全無法捕獲的死亡現場，例如由於app在背景產生的JetSam就發現常常無法捕獲到，這類問題就不在這裡討論。

### Signal
Mach会自动帮我们找到对应的signal type，我们用sys/signal.h的signal()即可统一捕获，而这类signal类型通常也会在backtrace中找到。

### abort
abort较麻烦，通常都会被统一抛出sigabrt的信号，较难深入定位，但我們至少可以抓出目前的backTrace以及exception名稱及原因，包含但不僅於以下幾種：
1. Jetsam : 因为iOS没有内存SWAP机制，导致系统需要杀掉一些优先级不高或者占用内存过大的app，并会在杀掉的当下抛出Jetsam，这类问题也须注意场景底下有没有leak产生。
2. 主线程死锁 : 因为死锁过久被watchDog回收，一般会出现0x8badf00d(ate bad food)的异常代码
3. _其他异常代码 ： 0xc00010ff（过热，cool off）, 0xdeadfa11（dead fall, 程序不响应被用户终止，iOS应该比较少）, 0xdead10cc（dead lock, 多半是讀取死鎖）....

詳情請看源碼。
