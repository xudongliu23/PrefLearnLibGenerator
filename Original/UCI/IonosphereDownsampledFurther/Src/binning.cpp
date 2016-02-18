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
	string ion_data_path = "../ionosphere.csv";
	string discrete_ion_data_path = "../ionosphere_discrete.csv";
	binning(ion_data_path, discrete_ion_data_path);

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
					if(atof(line_vals[i].c_str()) < 0.8705) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 2) {
					if(atof(line_vals[i].c_str()) < 0.0145) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 3) {
					if(atof(line_vals[i].c_str()) < 0.809) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 4) {
					if(atof(line_vals[i].c_str()) < 0.0199) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 5) {
					if(atof(line_vals[i].c_str()) < 0.728) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 6) {
					if(atof(line_vals[i].c_str()) < 0.014) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 7) {
					if(atof(line_vals[i].c_str()) < 0.681) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 8) {
					if(atof(line_vals[i].c_str()) < 0.017) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 9) {
					if(atof(line_vals[i].c_str()) < 0.6678) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 10) {
					if(atof(line_vals[i].c_str()) < 0.026) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 11) {
					if(atof(line_vals[i].c_str()) < 0.64) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 12) {
					if(atof(line_vals[i].c_str()) < 0.035) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 13) {
					if(atof(line_vals[i].c_str()) < 0.6) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 14) {
					if(atof(line_vals[i].c_str()) < 0.002) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 15) {
					if(atof(line_vals[i].c_str()) < 0.586) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 16) {
					if(atof(line_vals[i].c_str()) < 0.001) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 17) {
					if(atof(line_vals[i].c_str()) < 0.571) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 18) {
					if(atof(line_vals[i].c_str()) < -0.0001) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 19) {
					if(atof(line_vals[i].c_str()) < 0.498) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 20) {
					if(atof(line_vals[i].c_str()) < 0.0001) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 21) {
					if(atof(line_vals[i].c_str()) < 0.5315) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 22) {
					if(atof(line_vals[i].c_str()) < -0.0001) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 23) {
					if(atof(line_vals[i].c_str()) < 0.545) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 24) {
					if(atof(line_vals[i].c_str()) < -0.0152) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 25) {
					if(atof(line_vals[i].c_str()) < 0.701) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 26) {
					if(atof(line_vals[i].c_str()) < -0.018) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 27) {
					if(atof(line_vals[i].c_str()) < 0.4955) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 28) {
					if(atof(line_vals[i].c_str()) < -0.0001) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 29) {
					if(atof(line_vals[i].c_str()) < 0.4415) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 30) {
					if(atof(line_vals[i].c_str()) < -0.0001) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 31) {
					if(atof(line_vals[i].c_str()) < 0.4085) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else if(i == 32) {
					if(atof(line_vals[i].c_str()) < 0.00001) {ofile << "low,";}
					else {ofile << "high,";}
				}
				else {
					if(i == line_vals.size()-1) {
						ofile << line_vals[i];
					}
					else {
						ofile << (atoi(line_vals[i].c_str())==1?"high,":"low,");
					}
				}
			}
			ofile << endl;
    }
	}

	ifile.close();
	ofile.close();
}










