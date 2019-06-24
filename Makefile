all: main main_d main_aarch64 finished

#################################################################################################################################################################################

Semaphore.obj: lib/IPC/Semaphore.hpp src/IPC/Semaphore.cpp
	@g++ -c src/IPC/Semaphore.cpp -o obj/Semaphore.obj
	@echo "\033[1;35mGenerating Semaphore object code\033[0m"
	
Semaphore.obj_d: lib/IPC/Semaphore.hpp src/IPC/Semaphore.cpp
	@g++ -g -c src/IPC/Semaphore.cpp -o obj/debug/Semaphore.obj
	@echo "\033[1;36mGenerating Semaphore debug object code\033[0m"
	
Semaphore.obj_aarch64:
	@aarch64-linux-gnu-g++ -c src/IPC/Semaphore.cpp -o obj/aarch64_Semaphore.obj 
	@echo "\033[1;32mGenerating Semaphore aarch64 object code\033[0m"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Mailbox.obj: lib/IPC/Mailbox.hpp src/IPC/Mailbox.cpp
	@g++ -c src/IPC/Mailbox.cpp -o obj/Mailbox.obj
	@echo "\033[1;35mGenerating Mailbox object code\033[0m"

Mailbox.obj_d: lib/IPC/Mailbox.hpp src/IPC/Mailbox.cpp
	@g++ -g -c src/IPC/Mailbox.cpp -o obj/debug/Mailbox.obj
	@echo "\033[1;36mGenerating Mailbox debug object code\033[0m"

Mailbox.obj_aarch64:	
	@aarch64-linux-gnu-g++ -c src/IPC/Mailbox.cpp -o obj/aarch64_Mailbox.obj
	@echo "\033[1;32mGenerating Mailbox aarch64 object code\033[0m"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Socket.obj: lib/Socket.hpp src/Socket.cpp
	@g++ -c src/Socket.cpp -o obj/Socket.obj
	@echo "\033[1;35mGenerating Socket object code\033[0m"

Socket.obj_d: lib/Socket.hpp src/Socket.cpp
	@g++ -g -c src/Socket.cpp -o obj/debug/Socket.obj
	@echo "\033[1;36mGenerating Socket debug object code\033[0m"

Socket.obj_aarch64:
	@aarch64-linux-gnu-g++ -c src/Socket.cpp -o obj/aarch64_Socket.obj 
	@echo "\033[1;32mGenerating Socket aarch64 object code\033[0m"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Time.obj: lib/Time.hpp src/Time.cpp
	@g++ -c src/Time.cpp -o obj/Time.obj
	@echo "\033[1;35mGenerating Time object code\033[0m"

Time.obj_d: lib/Time.hpp src/Time.cpp
	@g++ -g -c src/Time.cpp -o obj/debug/Time.obj
	@echo "\033[1;36mGenerating Time debug object code\033[0m"

Time.obj_aarch64:
	@aarch64-linux-gnu-g++ -c src/Time.cpp -o obj/aarch64_Time.obj 
	@echo "\033[1;32mGenerating Time aarch64 object code\033[0m"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

MessageHandler.obj: lib/MessageHandler.hpp src/MessageHandler.cpp
	@g++ -c src/MessageHandler.cpp -o obj/MessageHandler.obj
	@echo "\033[1;35mGenerating MessageHandler object code\033[0m"

MessageHandler.obj_d: lib/MessageHandler.hpp src/MessageHandler.cpp
	@g++ -g -c src/MessageHandler.cpp -o obj/debug/MessageHandler.obj
	@echo "\033[1;36mGenerating MessageHandler debug object code\033[0m"

MessageHandler.obj_aarch64:
	@aarch64-linux-gnu-g++ -c src/MessageHandler.cpp -o obj/aarch64_MessageHandler.obj 
	@echo "\033[1;32mGenerating MessageHandler aarch64 object code\033[0m"


#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

FileManager.obj: lib/FileManager.hpp src/FileManager.cpp
	@g++ -c src/FileManager.cpp -o obj/FileManager.obj
	@echo "\033[1;35mGenerating FileManager object code\033[0m"

FileManager.obj_d: lib/FileManager.hpp src/FileManager.cpp
	@g++ -g -c src/FileManager.cpp -o obj/debug/FileManager.obj
	@echo "\033[1;36mGenerating FileManager debug object code\033[0m"

FileManager.obj_aarch64:
	@aarch64-linux-gnu-g++ -c src/FileManager.cpp -o obj/aarch64_FileManager.obj 
	@echo "\033[1;32mGenerating FileManager aarch64 object code\033[0m"

#--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

Network.obj: lib/Network.hpp src/Network.cpp
	@g++ -pthread -c src/Network.cpp -o obj/Network.obj
	@echo "\033[1;35mGenerating Network object code\033[0m"

Network.obj_d: lib/Network.hpp src/Network.cpp
	@g++ -pthread -g -c src/Network.cpp -o obj/debug/Network.obj
	@echo "\033[1;36mGenerating Network debug object code\033[0m"

Network.obj_aarch64:
	@aarch64-linux-gnu-g++ -c src/Network.cpp -o obj/aarch64_Network.obj 
	@echo "\033[1;32mGenerating Network aarch64 object code\033[0m"
	
#################################################################################################################################################################################

main.obj: src/main.cpp
	@g++ -c src/main.cpp -o obj/main.obj 
	@echo "\033[1;35mGenerating main object code\033[0m"

main.obj_d: src/main.cpp
	@g++ -g -c src/main.cpp -o obj/debug/main.obj
	@echo "\033[1;36mGenerating main debug object code\033[0m"

main.obj_aarch64: src/main.cpp
	@aarch64-linux-gnu-g++ -c src/main.cpp -o obj/aarch64_main.obj 
	@echo "\033[1;32mGenerating main aarch64 object code\033[0m"
	
#################################################################################################################################################################################

main: compileMessage Semaphore.obj Mailbox.obj Socket.obj MessageHandler.obj FileManager.obj Time.obj Network.obj  main.obj 
	@g++ -pthread obj/main.obj obj/Semaphore.obj obj/Mailbox.obj obj/Socket.obj obj/MessageHandler.obj obj/FileManager.obj obj/Time.obj obj/Network.obj -o bin/main
	@echo "\033[1;35mGenerating executable \033[0m"

main_d: compileMessage Semaphore.obj_d Mailbox.obj_d Socket.obj_d MessageHandler.obj_d FileManager.obj_d  Time.obj_d Network.obj_d main.obj_d 
	@g++ -pthread -g obj/debug/main.obj obj/debug/Semaphore.obj obj/debug/Mailbox.obj obj/debug/Socket.obj obj/debug/MessageHandler.obj obj/debug/FileManager.obj obj/debug/Time.obj obj/debug/Network.obj -o bin/debug/main
	@echo "\033[1;36mGenerating debug executable\033[0m"

main_aarch64: compileMessage Semaphore.obj_aarch64 Mailbox.obj_aarch64 Socket.obj_aarch64 MessageHandler.obj_aarch64 FileManager.obj_aarch64  Time.obj_aarch64 Network.obj_aarch64 main.obj_aarch64 
	@aarch64-linux-gnu-g++ -pthread obj/aarch64_main.obj obj/aarch64_Semaphore.obj obj/aarch64_Mailbox.obj obj/aarch64_Socket.obj obj/aarch64_MessageHandler.obj obj/aarch64_FileManager.obj obj/aarch64_Time.obj obj/aarch64_Network.obj -o bin/aarch64_main
	@echo "\033[1;32mGenerating aarch64 executable\033[0m"

#################################################################################################################################################################################

run:main runMessage 
	@.\/bin/main 
	@make finished --no-print-directory
debug:main_d debugMessage
	@gdb bin/debug/main
	@make finished --no-print-directory

#################################################################################################################################################################################

compileMessage:
	clear
	@echo "\033[1;31m----------------------------------------------------------------\033[0m"
	@echo "\033[1;33m                            Compiling                           \033[0m"
	@echo "\033[1;31m----------------------------------------------------------------\033[0m\n"

runMessage:
	@echo "\n\033[1;31m----------------------------------------------------------------\033[0m"
	@echo   "\033[1;33m                    Running the main program                    \033[0m"
	@echo   "\033[1;31m----------------------------------------------------------------\033[0m\n"

debugMessage:
	@echo "\n\033[1;31m----------------------------------------------------------------\033[0m"
	@echo   "\033[1;33m                   Debugging the main program                   \033[0m"
	@echo   "\033[1;31m----------------------------------------------------------------\033[0m\n"

finished:
	@echo "\n\033[1;31m----------------------------------------------------------------\033[0m"
	@echo     "\033[1;33m                            Finished                            \033[0m"
	@echo     "\033[1;31m----------------------------------------------------------------\033[0m\n"

#################################################################################################################################################################################