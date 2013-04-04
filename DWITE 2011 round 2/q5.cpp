#include <vector>
#include <set>
#include <iostream>
#include <string>

using namespace std;

int main () {
    freopen ("DATA5.txt", "r", stdin);
    freopen ("OUT5.txt", "w", stdout);

    for (int lol=0;lol<5;lol++){
    int n;
    cin>>n;
    string in1, in2;
    char op;
    vector<set<string> > net;
    bool flag;
    for (int i=0;i<5;i++){
        cin>>op>>in1>>in2;
        vector<set<string> >::iterator dex1,dex2;
        if (op=='p') {
            //11111111111111111111
            flag=false;
            for (vector<set<string> >::iterator it=net.begin(); it<net.end(); it++) {
                set<string>::iterator test=(*it).find(in1);
                if (test!=(*it).end()) {
                    dex1=it;
                    flag=true;
                    break;
                }
            }
            if (!flag) {
                set<string> newone;
                newone.insert(in1);
                net.push_back(newone);
                dex2=net.end()-1;
            }
            //2222222222222222222222222222
            flag=false;
            for (vector<set<string> >::iterator it=net.begin(); it<net.end(); it++) {
                set<string>::iterator test=(*it).find(in2);
                if (test!=(*it).end()) {
                    dex2=it;
                    flag=true;
                    break;
                }
            }
            if (!flag) {
                set<string> newone;
                newone.insert(in2);
                net.push_back(newone);
                dex2=net.end()-1;
            }
            //COMBINE!!!!!!!!!!!!!!!
            if (dex1!=dex2) {
                for (set<string>::iterator it=(*dex2).begin();it != (*dex2).end();it++)
                    (*dex1).insert(*it);
                net.erase(dex2);    
            }
        }
        else {
            flag=false;
            for (vector<set<string> >::iterator it=net.begin(); it<net.end(); it++) {
                if ((*it).find(in1)!=(*it).end() && (*it).end()!=(*it).find(in2)) {
                    flag=true;
                    cout<<"connected"<<endl;
                    break;
                }
            }
            if (!flag)
                cout<<"not connected"<<endl;

        }
    }
    }
    return 0;
}