/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.HashMap;

/**
 *
 * @author Georgiy
 */
public class QuestionThree {

    BufferedReader in;
    BufferedWriter out;
    String arg[];
    int N, M;
    HashMap<String, String> stores;
    HashMap<String, String> students;
    ArrayList<String> removelist;
    int matchcount;

    public QuestionThree() throws Exception {
	in = new BufferedReader(new FileReader("DATA3.txt"));
	out = new BufferedWriter(new FileWriter("OUT3.txt"));
	
	for (int qq = 0; qq < 5; qq++) {
	    resetVars();
	    loadStudentsAndStores();
	    addDoubles();
	    out.write(Integer.toString(matchcount));
	    out.newLine();
	    out("Result: " + matchcount);
	}
	out.close();
    }

    public void addDoubles() {
	for (String info : stores.keySet()) {
	    if (students.containsKey(info)&& !(removelist.contains(info))) {
		matchcount++;
	    }
	}
    }

    public void loadStudentsAndStores() throws Exception {
	for (int i = 0; i < N; i++) {
	    arg = in.readLine().split(" ");
	    out(Integer.toString(arg.length) + "," + arg[1]);
	    if (stores.containsKey(arg[1]) && !(stores.get(arg[1]).equals(arg[2]))) {
		removelist.add(arg[1]);
	    } else {
		stores.put(arg[1], arg[2]);
	    }
	}
	for (int i = 0; i < M; i++) {
	    arg = in.readLine().split(" ");
	    if (students.containsKey(arg[1]) && !(students.get(arg[1]).equals(arg[0]))) {
		removelist.add(arg[1]);
	    } else {
		students.put(arg[1], arg[0]);
	    }
	}
    }

    public void resetVars() throws Exception {
	stores = new HashMap<String, String>();
	students = new HashMap<String, String>();
	removelist = new ArrayList<String>();

	matchcount = 0;

	arg = in.readLine().split(" ");
	N = Integer.parseInt(arg[0]);
	out("Stores: " + N);
	M = Integer.parseInt(arg[1]);

    }

    static void out(String message) {
	System.out.println(message);
    }

    public static void main(String[] args) throws Exception {
	new QuestionThree();
    }
}