#include "mbed.h"
#include "machine.h"
#include "aho.h"

Serial pc(USBTX, USBRX);
AHO aho(pc);
Machine machine(1);

extern "C"
void HardFault_Handler() {
    printf("Hard Fault!\r\n");
    while(1);
}
 /*
// メモリ管理
void MemManage_Handler() {
    printf("MemManage Fault!\n");
    while(1);
}

// プリフェチ、メモリアクセス異常
void BusFault_Handler() {
    printf("BusFault Fault!\r\n");
    while(1);
}

// 未定義命令 or 異常状態
void UsageFault_Handler() {
    printf("Usage Fault!\r\n");
    while(1);
}
*/
int main() {
    printf("Hi, I'm SHIRO-OBI!\r\n");
    printf("Welcome to AHO system\r\n");
    aho.set_motion(machine.motion);
    while(1) {
        //machine.move_servo(0, 90);
        /*
        if(aho.has_changed()){
            machine.play_motion(0);
        }
        */
        //printf("hello\r\n");
        int port = 0;
        for(int i=45;i<90;i++){
            machine.move_servo(port, i);
            printf("%d, %d\r\n", port, i);
            wait(0.1);
        }
        for(int i=90;i>45;i--){
            machine.move_servo(port, i);
            printf("%d, %d\r\n", port, i);
            wait(0.1);
        }
    }
}
