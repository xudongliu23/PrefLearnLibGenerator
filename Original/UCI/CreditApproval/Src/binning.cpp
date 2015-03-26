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
	string credit_approval_data_path = "../credit_approval.csv";
	string discrete_credit_approval_data_path = "../discrete_credit_approval.csv";
	binning(credit_approval_data_path, discrete_credit_approval_data_path);

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
				if(i == 1) {
					if(atof(line_vals[i].c_str()) < 22.51) {ofile << "low,";}
					else if(atof(line_vals[i].c_str()) < 28.1) {ofile << "medium,";}
					else if(atof(line_vals[i].c_str()) < 37.4) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 2) {
					if(atof(line_vals[i].c_str()) < 1.01) {ofile << "low,";}
					else if(atof(line_vals[i].c_str()) < 2.72) {ofile << "medium,";}
					else if(atof(line_vals[i].c_str()) < 7.01) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 7) {
					if(atof(line_vals[i].c_str()) < 0.166) {ofile << "low,";}
					else if(atof(line_vals[i].c_str()) < 1.01) {ofile << "medium,";}
					else if(atof(line_vals[i].c_str()) < 2.51) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 10) {
					if(atof(line_vals[i].c_str()) < 0.5) {ofile << "low,";}
					else if(atof(line_vals[i].c_str()) < 2.5) {ofile << "medium,";}
					else if(atof(line_vals[i].c_str()) < 7.5) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 13) {
					if(atoi(line_vals[i].c_str()) < 63) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 151) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 255) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 14) {
					if(atof(line_vals[i].c_str()) < 0.5) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 69) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 801) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else {
					if(i == 15) {ofile << line_vals[i];}
					else {ofile << line_vals[i] << ",";}
				}
			}
			ofile << endl;
    }
	}

	ifile.close();
	ofile.close();
}










