import processing.net.*;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.io.IOException;

Client c; 
int data;
Robot robot;
int rel_w = 0;
int rel_s = 0;                        //releasing variaVles :P
int rel_a = 0;
int rel_d = 0;
int rel_alt = 0;
int rel_space = 0;

void setup() { 
  size(200, 200); 
  background(50); 
  fill(200);
  c = new Client(this, "192.168.225.120", 23);  // Connect to server on port 23 
  try {
    //Launch NotePad
    //Runtime.getRuntime().exec("notepad");
    robot = new Robot();
  }
  catch (Exception e) {
    //Uh-oh...
    e.printStackTrace();
    exit();
  }
  try {
  Runtime.getRuntime().exec("C:\\Users\\Soham Halder\\Desktop\\there.vbs");
  }
  catch(Exception i){
  }
    //
  }
void draw() {
  if (c.available() > 0) {    // If there's incoming data from the client...
    data = c.read();   // ...then grab it and print it
    //data = data.substring(0, data.indexOf("\n"));
    print(data);
    println("end");
    if(data == 87){
        if(rel_d!=1){
          robot.keyRelease(KeyEvent.VK_D);;
        }
        if(rel_s!=1){
          robot.keyRelease(KeyEvent.VK_S);;
        }
        if(rel_a!=1){
          robot.keyRelease(KeyEvent.VK_A);;
        }
        if(rel_space!=1){
          robot.keyRelease(KeyEvent.VK_SPACE);;                                       ////release the spacebar
        }
        if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);                             ////release the nitrous
        }
        robot.keyPress(KeyEvent.VK_W);;
        rel_w = 0;
        rel_s=1;
        rel_d=1;
        rel_a=1;
        rel_alt=1;
        rel_space=1;
      }
      else if(data == 83){
        if(rel_d!=1){
          robot.keyRelease(KeyEvent.VK_D);;
        }
        if(rel_w!=1){
          robot.keyRelease(KeyEvent.VK_W);;
        }
        if(rel_a!=1){
          robot.keyRelease(KeyEvent.VK_A);;
        }
        if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);                             ////release the nitrous
        }
        if(rel_space!=1){
          robot.keyRelease(KeyEvent.VK_SPACE);;                                       ////release the spacebar
        }
        robot.keyPress(KeyEvent.VK_S);;
        rel_s=0;
        rel_w=1;
        rel_d=1;
        rel_a=1;
        rel_alt=1;
        rel_space=1;
      }

      ///Nitrous Mixes start ::::::::::::P

      else if(data == 109){
        if(rel_d!=1){
          robot.keyRelease(KeyEvent.VK_D);;
        }
        if(rel_s!=1){
          robot.keyRelease(KeyEvent.VK_S);;
        }
        if(rel_a!=1){
          robot.keyRelease(KeyEvent.VK_A);;
        }
        if(rel_space!=1){
          robot.keyRelease(KeyEvent.VK_SPACE);;                                       ////release the spacebar
        }
        robot.keyPress(KeyEvent.VK_ALT);                             ////with the nitrous
        robot.keyPress(KeyEvent.VK_W);;
        rel_s=1;
        rel_w=0;
        rel_d=1;
        rel_a=1;
        rel_alt=0;
        rel_space=1;
      }

      else if(data == 110){
        if(rel_d!=1){
          robot.keyRelease(KeyEvent.VK_D);;
        }
        if(rel_s!=1){
          robot.keyRelease(KeyEvent.VK_S);;
        }
        if(rel_space!=1){
          robot.keyRelease(KeyEvent.VK_SPACE);;                                       ////release the spacebar
        }
        robot.keyPress(KeyEvent.VK_A);;
        robot.keyPress(KeyEvent.VK_ALT);                             ////with the nitrous and 'a'
        robot.keyPress(KeyEvent.VK_W);;
        rel_s=1;
        rel_w=0;
        rel_d=1;
        rel_a=0;
        rel_alt=0;
        rel_space=1;
      }

      else if(data == 111){
        if(rel_a!=1){
          robot.keyRelease(KeyEvent.VK_A);;
        }
        if(rel_s!=1){
          robot.keyRelease(KeyEvent.VK_S);;
        }
        if(rel_space!=1){
          robot.keyRelease(KeyEvent.VK_SPACE);;                                       ////release the spacebar
        }
        robot.keyPress(KeyEvent.VK_D);;
        robot.keyPress(KeyEvent.VK_ALT);                             ////with the nitrous and 'd'
        robot.keyPress(KeyEvent.VK_W);;
        rel_s=1;
        rel_w=0;
        rel_d=0;
        rel_a=1;
        rel_alt=0;
        rel_space=1;
      }

      ///Nitrous Mixes end ::::::::::::::

      ///Handbrake Mixes start :::::::::::::

      else if(data == 108){
        if(rel_d!=1){
          robot.keyRelease(KeyEvent.VK_D);;
        }
        if(rel_w!=1){
          robot.keyRelease(KeyEvent.VK_W);;
        }
        if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);                      ////release the nitrous
        }
        robot.keyPress(KeyEvent.VK_A);;
        robot.keyPress(KeyEvent.VK_SPACE);;                             ////with the spacebar and 's'
        robot.keyPress(KeyEvent.VK_S);;
        rel_s=0;
        rel_w=1;
        rel_d=1;
        rel_a=0;                                          ////SA' '
        rel_alt=1;
        rel_space=0;
      }

      else if(data == 107){
        if(rel_a!=1){
          robot.keyRelease(KeyEvent.VK_A);;
        }
        if(rel_w!=1){
          robot.keyRelease(KeyEvent.VK_W);;
        }
        if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);           ////release the nitrous
        }
        robot.keyPress(KeyEvent.VK_D);;
        robot.keyPress(KeyEvent.VK_SPACE);;                        ////without the nitrous and 's'
        robot.keyPress(KeyEvent.VK_S);;
        rel_s=0;
        rel_w=1;
        rel_d=0;                                      ////SD' '
        rel_a=1;
        rel_alt=1;
        rel_space=0;
      }

      else if(data == 105){
        if(rel_d!=1){
          robot.keyRelease(KeyEvent.VK_D);;
        }
        if(rel_s!=1){
          robot.keyRelease(KeyEvent.VK_S);;
        }
        if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);                      ////release the nitrous
        }
        robot.keyPress(KeyEvent.VK_A);;
        robot.keyPress(KeyEvent.VK_SPACE);;                             ////with the spacebar and 's'
        robot.keyPress(KeyEvent.VK_W);;
        rel_s=1;
        rel_w=0;
        rel_d=1;
        rel_a=0;                                          ////WA' '
        rel_alt=1;
        rel_space=0;
      }

      else if(data == 117){
        if(rel_a!=1){
          robot.keyRelease(KeyEvent.VK_A);;
        }
        if(rel_s!=1){
          robot.keyRelease(KeyEvent.VK_S);;
        }
        if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);           ////release the nitrous
        }
        robot.keyPress(KeyEvent.VK_D);;
        robot.keyPress(KeyEvent.VK_SPACE);;                        ////with the handbrake and 'w'
        robot.keyPress(KeyEvent.VK_W);;
        rel_s=1;
        rel_w=0;
        rel_d=0;                                      ////WD' '
        rel_a=1;
        rel_alt=1;
        rel_space=0;
      }

      else if(data == 106){
        if(rel_d!=1){
          robot.keyRelease(KeyEvent.VK_D);;
        }
        if(rel_s!=1){
          robot.keyRelease(KeyEvent.VK_S);;
        }
        if(rel_w!=1){
          robot.keyRelease(KeyEvent.VK_W);;
        }
        if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);           ////release the nitrous
        }
        robot.keyPress(KeyEvent.VK_A);;
        robot.keyPress(KeyEvent.VK_SPACE);;                        ////without the nitrous and 's'
        rel_s=1;
        rel_w=1;
        rel_d=1;                                      ////A' '
        rel_a=0;
        rel_alt=1;
        rel_space=0;
      }

      else if(data == 104){
        if(rel_a!=1){
          robot.keyRelease(KeyEvent.VK_A);;
        }
        if(rel_s!=1){
          robot.keyRelease(KeyEvent.VK_S);;
        }
        if(rel_w!=1){
          robot.keyRelease(KeyEvent.VK_W);;
        }
        if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);           ////release the nitrous
        }
        robot.keyPress(KeyEvent.VK_D);;
        robot.keyPress(KeyEvent.VK_SPACE);;                        ////without the nitrous and 's'
        rel_s=1;
        rel_w=1;
        rel_d=0;                                      ////D' '
        rel_a=1;
        rel_alt=1;
        rel_space=0;
      }

      ///Handbrake Mixes end ::::::::::::::
      
      ///Normal Mixes start :::::::::::::

      else if(data == 113){        /*/////::::::::: for WD ::::::::://///*/
        if(rel_s!=1){
          robot.keyRelease(KeyEvent.VK_S);;
        }
        if(rel_a!=1){
          robot.keyRelease(KeyEvent.VK_A);;
        }
        if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);                             ////release the nitrous
        }
        if(rel_space!=1){
          robot.keyRelease(KeyEvent.VK_SPACE);;                                       ////release the spacebar
        }
        robot.keyPress(KeyEvent.VK_W);;
        robot.keyPress(KeyEvent.VK_D);;
        rel_w=0;
        rel_d=0;
        rel_a=1;
        rel_s=1;
        rel_alt=1;
        rel_space=1;
      }

      else if(data == 119){        /*/////::::::::: for WA ::::::::://///*/
        if(rel_s!=1){
          robot.keyRelease(KeyEvent.VK_S);;
        }
        if(rel_d!=1){
          robot.keyRelease(KeyEvent.VK_D);;
        }
        if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);                             ////release the nitrous
        }
        if(rel_space!=1){
          robot.keyRelease(KeyEvent.VK_SPACE);;                                       ////release the spacebar
        }
        robot.keyPress(KeyEvent.VK_W);;
        robot.keyPress(KeyEvent.VK_A);;
        rel_w=0;
        rel_d=1;
        rel_a=0;
        rel_s=1;
        rel_alt = 1;
        rel_space=1;
      }

      else if(data == 97){        /*/////::::::::: for SA ::::::::://///*/
        if(rel_w!=1){
          robot.keyRelease(KeyEvent.VK_W);;
        }
        if(rel_d!=1){
          robot.keyRelease(KeyEvent.VK_D);;
        }
        if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);                             ////release the nitrous
        }
        if(rel_space!=1){
          robot.keyRelease(KeyEvent.VK_SPACE);;                                       ////release the spacebar
        }
        robot.keyPress(KeyEvent.VK_S);;
        robot.keyPress(KeyEvent.VK_A);;
        rel_w=1;
        rel_d=1;
        rel_a=0;
        rel_s=0;
        rel_alt = 1;
        rel_space=1;
      }

      else if(data == 100){        /*/////::::::::: for SD ::::::::://///*/
        if(rel_w!=1){
          robot.keyRelease(KeyEvent.VK_W);;
        }
        if(rel_a!=1){
          robot.keyRelease(KeyEvent.VK_A);;
        }
        if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);                             ////release the nitrous
        }
        if(rel_space!=1){
          robot.keyRelease(KeyEvent.VK_SPACE);;                                       ////release the spacebar
        }
        robot.keyPress(KeyEvent.VK_S);;
        robot.keyPress(KeyEvent.VK_D);;
        rel_w=1;
        rel_d=0;
        rel_a=1;
        rel_s=0;
        rel_alt = 1;
        rel_space=1;
      }

      ///Normal Mixes end ::::::::::::::::
        
      else if(data == 65){
        if(rel_d!=1){
          robot.keyRelease(KeyEvent.VK_D);;}
        if(rel_w!=1){
          robot.keyRelease(KeyEvent.VK_W);;
        }
         if(rel_s!=1){
          robot.keyRelease(KeyEvent.VK_S);;
        }
          if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);                             ////release the nitrous
        }
        if(rel_space!=1){
          robot.keyRelease(KeyEvent.VK_SPACE);;                                       ////release the spacebar
        }
          //if(rel_a!=0){                   ///for checking if it causes conflict{not sure}
        robot.keyPress(KeyEvent.VK_A);;
        rel_w=1;
        rel_s=1;
        rel_a=0;
        rel_d = 1;
        rel_alt = 1;
        rel_space=1;
      }
      else if(data == 68){
        if(rel_a!=1){
          robot.keyRelease(KeyEvent.VK_A);;}
        if(rel_alt!=1){
          robot.keyRelease(KeyEvent.VK_ALT);                             ////release the nitrous
        }
        if(rel_w!=1){
          robot.keyRelease(KeyEvent.VK_W);;
        }
         if(rel_s!=1){
          robot.keyRelease(KeyEvent.VK_S);;
        }
        if(rel_space!=1){
          robot.keyRelease(KeyEvent.VK_SPACE);;                                       ////release the spacebar
        }
        //if(rel_d!=0){                   ///for checking if it causes conflict{not sure}
        robot.keyPress(KeyEvent.VK_D);;
        rel_w=1;
        rel_s=1;
        rel_d = 0;
        rel_a = 1;
        rel_alt = 1;
        rel_space=1;
      }
      else if(data == 48&&(rel_a!=1||rel_s!=1||rel_d!=1||rel_w!=1||rel_alt!=1||rel_space!=1)){
        //robot.keyReleaseAll();
        robot.keyRelease(KeyEvent.VK_W);
        robot.keyRelease(KeyEvent.VK_S);
        robot.keyRelease(KeyEvent.VK_ALT);
        robot.keyRelease(KeyEvent.VK_D);
        robot.keyRelease(KeyEvent.VK_A);
        robot.keyRelease(KeyEvent.VK_SPACE);
      }
    else{
      println("Something else is happening");
    }
  } 
}
