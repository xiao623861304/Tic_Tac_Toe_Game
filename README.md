# Tic_Tac_Toe_Game

<img src="https://github.com/xiao623861304/Tic_Tac_Toe_Game/blob/master/iphone8%20plus.gif" width="40%" height="40%"> 
<img src="https://github.com/xiao623861304/Tic_Tac_Toe_Game/blob/master/iphoneX.gif" width="40%" height="40%">


For this app , The functions completed are as follows : 

Basic function : 
Complete the basic Two player mode of play according to rules of tic tac toe, allowing players to start new games .

Extension : 

Two Player Pattern : 

You can click the different buttons on title to change the board format and change the rules of the game, such as the 4x4 chessboard, which must be connected to 4 same pieces in the chessboard, after then will be win , 5x5 is the same rules .

Single Player Pattern :

Add a computer mode into a easy computer model and a computer model that you can't win. (it takes time to complete this computer model(impossible win ). Logic is introduced below).

App FrameWork

Using the standard MVC design pattern , make the project structure clear and easy to read . 

M - Model : Initialization of data , including the array of Cross and Circle , and the function of determine result (The algorithm of judging and winning). 

V - View : Create chessboard view, single player mode select level pop-up view, multiplayer mode select chessboard type view, create cross and circle view .

C - Controller : The single person mode creates the interactive mode of different levels of computers and people (including the operation logic of chess in every step of the computer) , select the pop-up logic of the user interface when the level is selected, the multi person mode double interaction logic, and the logic operation of restart game .

iOS Technology : 

1. The operation of view to controller uses the delegation , It solves the problem that the controller is overstaffed and the proxy object can be reused. Easy to expand . 

2. More lazy loading is used when creating objects, because only when the resources are really needed, and then loaded again, and only once, saving the memory resources (the memory footprint of the system is reduced).

3 Using third party SnapKit to achieve automatic layout, suitable for all kinds of device, more convenient.

4 Header file create global variables so that they can be easily used throughout the project. 

5 Using the CocoaPod managed the third library . 


Computer logic introduce : 

Easy : put chess pieces at random .(In the empty space) 

Impossible Win : Before the computer put pieces , first judge whether the computer has the possibility of winning, there is, place the pieces in this position, if not, to judge where the player may win, if has ,to block, the detail logical reference code.
