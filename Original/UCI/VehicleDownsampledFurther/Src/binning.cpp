#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>
using namespace std;

typedef vector<string> vs;

vs getSubstringsByComma(string input);
void binning(string input, string output);

int main() {
	string vehicle_data_path = "../vehicle.csv";
	string discrete_vehicle_data_path = "../discrete_vehicle.csv";
	binning(vehicle_data_path, discrete_vehicle_data_path);

	return 0;
}

vs getSubstringsByComma(string input) {
	istringstream ss(input);
	string token;
	vs res;
	
	while(getline(ss, token, ',')) {
		res.push_back(token);
	} // the last string is the classification

	return res;
}

void binning(string input, string output) {
	ifstream ifile;
	ofstream ofile;

	ifile.open(input.c_str());
	ofile.open(output.c_str());

	if(!ifile.is_open() || !ofile.is_open()) {cout << "Error opening file!" << endl;exit(1);}
	else {
		string line;
    while(getline(ifile, line)) {
			vs line_vals = getSubstringsByComma(line);
			for(int i=0; i<line_vals.size(); i++) {
				if(i == 0) {
					if(atoi(line_vals[i].c_str()) < 88) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 93) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 100) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 1) {
					if(atoi(line_vals[i].c_str()) < 41) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 45) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 50) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 2) {
					if(atoi(line_vals[i].c_str()) < 71) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 80) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 97) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 3) {
					if(atoi(line_vals[i].c_str()) < 142) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 167) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 195) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 4) {
					if(atoi(line_vals[i].c_str()) < 58) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 62) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 66) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 5) {
					if(atoi(line_vals[i].c_str()) < 7) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 9) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 11) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 6) {
					if(atoi(line_vals[i].c_str()) < 147) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 158) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 198) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 7) {
					if(atoi(line_vals[i].c_str()) < 34) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 43) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 46) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 8) {
					if(atoi(line_vals[i].c_str()) < 19) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 20) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 23) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 9) {
					if(atoi(line_vals[i].c_str()) < 137) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 146) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 160) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 10) {
					if(atoi(line_vals[i].c_str()) < 168) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 179) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 217) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 11) {
					if(atoi(line_vals[i].c_str()) < 319) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 364) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 585) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 12) {
					if(atoi(line_vals[i].c_str()) < 150) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 174) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 198) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 13) {
					if(atoi(line_vals[i].c_str()) < 68) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 72) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 76) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 14) {
					if(atoi(line_vals[i].c_str()) < 3) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 6) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 10) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 15) {
					if(atoi(line_vals[i].c_str()) < 6) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 12) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 19) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 16) {
					if(atoi(line_vals[i].c_str()) < 185) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 189) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 194) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 17) {
					if(atoi(line_vals[i].c_str()) < 191) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 197) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 202) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else {
					ofile << line_vals[i];
				}
			}
			ofile << endl;
    }
	}

	ifile.close();
	ofile.close();
}










