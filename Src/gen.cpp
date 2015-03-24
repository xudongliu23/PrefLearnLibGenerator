/* Given the classification datasets from UCI, compute and output the strict and equivalent examples. */

#include <iostream>
#include <vector>
#include <string>
#include <utility>
#include <fstream>
#include <unordered_map>

using namespace std;

typedef unordered_map<string,int> label_rank_map;
typedef pair<string,string> pss;
typedef vector<pss> vpss;

#define REP(i,a,b) \
	for(int i=(int)a; i<=(int)b; i++)
#define IT(it,list) \
	for(auto it=list.begin(); it!=list.end(); it++)

label_rank_map getLabelRanks(string label_ranks_path);
void generatePrefLearnData(string class_dataset_path, string strict_examples_path, string eq_examples_path, label_rank_map &my_lrm);


int main(int argc, char** argv) {
	if(argc != 5) {cout << "Wrong number of arguments!\nSystem aborted!" << endl; exit(1);}
	else{
		string label_ranks_path = string(argv[1]);
		string class_dataset_path = string(argv[2]);
		string strict_examples_path = string(argv[3]);
		string eq_examples_path = string(argv[4]);
	
		label_rank_map my_lrm = getLabelRanks(label_ranks_path);
		generatePrefLearnData(class_dataset_path, strict_examples_path, eq_examples_path, my_lrm);
	}

	return 0;
}

label_rank_map getLabelRanks(string label_ranks_path) {
	ifstream ifile;
	label_rank_map my_lrm;

	ifile.open(label_ranks_path.c_str());

	if(!ifile.is_open()) {cout << "Error opening file!" << endl;}
	else {
		string line;
		while(getline(ifile, line)) {
			size_t found_comma = line.find(",");
			string label = line.substr(0, found_comma);
			int rank = atoi(line.substr(found_comma+1).c_str()); // smaller rank is more preferred.
			my_lrm.insert(make_pair(label, rank));
		}
	}

	ifile.close();
	return my_lrm;
}

void generatePrefLearnData(string class_dataset_path, string strict_examples_path, string eq_examples_path, label_rank_map &my_lrm) {
	ifstream cfile;
	ofstream sfile;
	ofstream efile;

	vpss outcomes_labels;
	
	cfile.open(class_dataset_path.c_str());
	sfile.open(strict_examples_path.c_str());
	efile.open(eq_examples_path.c_str());

	if(!cfile.is_open() || !sfile.is_open() || !efile.is_open()) {cout << "Error opening file!" << endl;}
	else {
		sfile << "UserID,Outcome1ID,Outcome2ID" << endl;
		efile << "UserID,Outcome1ID,Outcome2ID" << endl;

		string line;
		while(getline(cfile, line)) {
			size_t found_last_comma = line.find_last_of(",");
			string outcome = line.substr(0, found_last_comma);
			string label = line.substr(found_last_comma+1);
			outcomes_labels.push_back(make_pair(outcome, label));
		}

		REP(i, 0, outcomes_labels.size()-1) {
			REP(j, i+1, outcomes_labels.size()-1) {
				string label_i = outcomes_labels[i].second;
				string label_j = outcomes_labels[j].second;
				int rank_i = my_lrm[label_i];
				int rank_j = my_lrm[label_j];
	
				if(rank_i < rank_j) {
					sfile << "1," << i+1 << "," << j+1 << endl;
				}
				else if(rank_i > rank_j) {
					sfile << "1," << j+1 << "," << i+1 << endl;
				}
				else {
					efile << "1," << i+1 << "," << j+1 << endl;
				}
			}
		}
	}

	cfile.close();
	sfile.close();
	efile.close();
}













