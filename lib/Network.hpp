#ifndef NETWORK_HPP
#define NETWORK_HPP

#include "FileManager.hpp"
#include "MessageHandler.hpp"
#include "Socket.hpp"
#include "Translator.hpp"

#include <netdb.h>
#include <ifaddrs.h>

#include <vector>
#include <map>
#include <thread>
#include <mutex>

#define PROC_NET_ROUTE_LINE_SIZE 128
#define NETWORK_INTERFACE_MAX_LENGTH 15
#define IP_MAX_SIZE 15
#define CONECTION_RETRIES 10

#define forever for(int iteration=0;;iteration++)

struct ACK{
	unsigned int ip;															
	unsigned short port;														
	unsigned char frameNum;															// fragment id
	ACK(unsigned int dir, unsigned short p, unsigned short n){ip = dir; port = p; frameNum = n;}
};

struct PacketHeader{
	unsigned int messageSize;													// Full Message Size
	unsigned int from;															// Sender
	unsigned int to;															// Receiver
	unsigned short portFrom;													// Sender port
	unsigned short portTo;														// Receiver port
	unsigned short id;															// fragment id
	unsigned char dataSize;														// 0 - MAX_DATA_SIZE
	char frameNum;																// 0|1 stop and wait
	PacketHeader():frameNum(-1){}
	PacketHeader(unsigned int ip, unsigned short port):frameNum(-1){to = ip; portTo = port;}
	PacketHeader(const char * ip, unsigned short port):frameNum(-1){
		Translator translator;
		to = translator.constCharIptoIntIp(ip);
		portTo = port;
	}
};

const int MAX_WIRE_SIZE = 64;
const int MAX_DATA_SIZE = MAX_WIRE_SIZE - sizeof(PacketHeader);

struct Packet{
	PacketHeader header;
	char data[MAX_DATA_SIZE];
};

class Network{
	public:
		// Constructor.
		Network(int Port, double reliability);
		// Destructor.
		~Network();
		
		// Packet Fragmentation.
		void sendMessage(PacketHeader header, const char * message);
		// Defragmentation.
		PacketHeader receiveMessage(char * message);

		void sendACK(PacketHeader header);

		void receiveACK(PacketHeader header, bool &timeout, bool &acknowledged);
		
		// Manages timeout
		void runClock(bool &timeout, bool &acknowledged);

		void send(PacketHeader header, const char * data);				// Packet send
		
		void sendDone();												
		void checkPacketAvailable();									// Packet receive
		PacketHeader receive(char * data, PacketHeader header);								// Packet pickup
		
	private:
		// Machine ID
		unsigned int ip;
		unsigned short port;

		// Control Flags

		bool firstPacketAvailable;
		bool exit;
		int connectionLost;

		Socket socket;
		std::mutex sendingPacket;
		std::mutex acknowledge;
		std::mutex receiving;
		
		std::thread receiver;
		Translator translator;
		std::vector<Packet> firstPacket;
		std::map<unsigned int,std::map<unsigned short,std::vector<Packet>>> receivedPackets;
		std::map<unsigned int,std::map<unsigned short,bool>> incommingMessage;
		std::map<unsigned int,std::map<unsigned short,char>> receivedACK;
		std::map<unsigned int,std::map<unsigned short,char>> lastSendedACK;

		std::vector<Packet> fragments;
		
		double reliability;
		


		void readHandler(PacketHeader header);												// one packet lecture at time
		void writeHandler();											// one packet write at time
		Packet byteArrayToPacket(const unsigned char * bytes);			// gets an array of bytes and transforms it into a packet
		void getLocalIp(char * ip, int family = AF_INET);				// gets this machine local ip
		void getDefaultInterface(char * interface);						// gets this machine default interface from "/proc/net/route"
};

#endif /* NETWORK_HPP */
