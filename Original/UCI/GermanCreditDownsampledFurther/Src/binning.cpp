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
	string german_credit_data_path = "../german_credit.csv";
	string discrete_german_credit_data_path = "../discrete_german_credit.csv";
	binning(german_credit_data_path, discrete_german_credit_data_path);

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
					if(atoi(line_vals[i].c_str()) < 13) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 19) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 25) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 4) {
					if(atoi(line_vals[i].c_str()) < 1365) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 2320) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 3973) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 12) {
					if(atoi(line_vals[i].c_str()) < 27) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 34) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 43) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else {
					if(i == line_vals.size()-1) {
						ofile << line_vals[i];
					}
					else {
						ofile << line_vals[i] << ",";
					}
				}
			}
			ofile << endl;
    }
	}

	ifile.close();
	ofile.close();
}










