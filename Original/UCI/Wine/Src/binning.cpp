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
	string scaled_wine_data_path = "../scaled_wine.csv";
	string discrete_wine_data_path = "../discrete_wine.csv";
	binning(scaled_wine_data_path, discrete_wine_data_path);

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
					if(atoi(line_vals[i].c_str()) < 1237) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 1306) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 1370) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 1) {
					if(atoi(line_vals[i].c_str()) < 161) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 188) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 313) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 2) {
					if(atoi(line_vals[i].c_str()) < 221) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 237) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 258) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 3) {
					if(atoi(line_vals[i].c_str()) < 172) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 196) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 216) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 4) {
					if(atoi(line_vals[i].c_str()) < 89) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 99) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 110) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 5) {
					if(atoi(line_vals[i].c_str()) < 175) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 237) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 281) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 6) {
					if(atoi(line_vals[i].c_str()) < 121) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 215) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 290) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 7) {
					if(atoi(line_vals[i].c_str()) < 27) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 34) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 46) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 8) {
					if(atoi(line_vals[i].c_str()) < 125) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 157) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 197) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 9) {
					if(atoi(line_vals[i].c_str()) < 322) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 471) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 626) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 10) {
					if(atoi(line_vals[i].c_str()) < 79) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 98) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 113) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 11) {
					if(atoi(line_vals[i].c_str()) < 195) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 279) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 319) {ofile << "high,";}
					else {ofile << "vhigh,";}
				}
				else if(i == 12){
					if(atoi(line_vals[i].c_str()) < 501) {ofile << "low,";}
					else if(atoi(line_vals[i].c_str()) < 676) {ofile << "medium,";}
					else if(atoi(line_vals[i].c_str()) < 991) {ofile << "high,";}
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










