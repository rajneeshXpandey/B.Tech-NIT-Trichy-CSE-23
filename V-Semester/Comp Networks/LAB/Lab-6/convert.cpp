#include <bits/stdc++.h>
#define endl '\n'
#include <iostream>

using namespace std;

void strtok(string s, vector<string> &arr) {
  stringstream ss(s);
  string word;
  while (ss >> word) {
    arr.push_back(word);
  }
}

class packetDropRatio {
  int packet_sent;
  int packet_recv;
  int packet_drop;
  int to, from;
  ofstream f;

public:
  packetDropRatio(string filename, int to1, int from1) {
    to = to1;
    from = from1;
    packet_sent = 0;
    packet_drop = 0;
    packet_recv = 0;
    f.open(filename + "_plr");
  }
  ~packetDropRatio() { f.close(); }
  void processPacketData(char event, float timestamp, int toNode,
                         int fromNode) {
    if (event == 'r' && toNode >= to) {
      packet_recv++;
    }
    if (event == 'd')
      packet_drop++;
    if (event == '+' && fromNode <= from) {
      packet_sent++;
    }
    // if (packet_sent != 0)
    //   f << timestamp << " " << (float)(packet_drop) / packet_sent << endl;
  }
  void print() {
    if (packet_sent != 0)
      cout << "PLR : " << (float)(packet_drop) / packet_sent << endl;
  }
};

class packetDeliveryRatio {
  int packet_sent;
  int packet_recv;
  int packet_drop;
  int to, from;
  ofstream f;

public:
  packetDeliveryRatio(string filename, int to1, int from1) {
    to = to1;
    from = from1;
    packet_sent = 0;
    packet_drop = 0;
    packet_recv = 0;
    f.open(filename + "_pdr");
  }
  ~packetDeliveryRatio() { f.close(); }
  void processPacketData(char event, float timestamp, int toNode,
                         int fromNode) {
    if (event == 'r' && toNode >= to) {
      packet_recv++;
    }
    if (event == 'd')
      packet_drop++;
    if (event == '+' && fromNode <= from) {
      packet_sent++;
    }
    // if (packet_sent != 0)
    //   f << timestamp << " " << (float)(packet_recv) / packet_sent << endl;
  }
  void print() {
    if (packet_sent != 0)
      cout << "PDR : " << (float)(packet_recv) / packet_sent << endl;
  }
};

class controlOverhead {
  ofstream f;
  long int total_packets, control_packets;

public:
  controlOverhead(string filename) {
    total_packets = 0;
    control_packets = 0;
    f.open(filename + "_co");
  }
  ~controlOverhead() { f.close(); }
  void processPacketData(char event, float timestamp, string packetType) {
    if (event == '+') {
      total_packets++;
      if (packetType == "ack") {
        control_packets++;
      }
    }
    // f << timestamp << " " << (float)(control_packets) / (total_packets) << endl;
  }
  void print() {
    if (total_packets != 0)
      cout << "CO : " << (float)(control_packets) / total_packets << endl;
  }
};

int main(int argc, char **argv) {
  // control variabels
  char event;
  float timestamp;
  int fromNode, toNode;
  string packetType;
  float srcAddr, toAddr;
  int packetId;
  int packetSize;
  int seqId;
  // globals
  if (argc != 5) {
    cout << " error:" << endl;
    exit(0);
  }
  int toNodeFromArgv = atoi(argv[3]);
  int fromNodeFromArgv = atoi(argv[2]);
  string filename(argv[1]);
  string outfile(argv[4]);
  ifstream f(filename);
  string temp;
  packetDropRatio plr(outfile, toNodeFromArgv, fromNodeFromArgv);
  packetDeliveryRatio pdr(outfile, toNodeFromArgv, fromNodeFromArgv);
  controlOverhead co(outfile);

  while (getline(f, temp)) {
    vector<string> tokens;
    strtok(temp, tokens);
    if (tokens.size() < 12)
      continue;
    event = tokens[0][0];
    timestamp = stof(tokens[1]);
    fromNode = stoi(tokens[2]);
    toNode = stoi(tokens[3]);
    packetType = tokens[4];
    packetSize = stoi(tokens[5]);
    srcAddr = stof(tokens[8]);
    toAddr = stof(tokens[9]);
    seqId = stoi(tokens[10]);
    packetId = stoi(tokens[11]);

    pdr.processPacketData(event, timestamp, toNode, fromNode);
    plr.processPacketData(event, timestamp, toNode, fromNode);
    co.processPacketData(event, timestamp, packetType);
  }
  pdr.print();
  plr.print();
  co.print();
}
