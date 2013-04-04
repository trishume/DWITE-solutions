import java.io.*;
class Problem2 {
	public static void main(String args[]) {
		try{
			// Open the file that is the first 
			// command line parameter
			FileInputStream fstream = new FileInputStream("DATA2.txt");
			// Get the object of DataInputStream
			DataInputStream in = new DataInputStream(fstream);
			BufferedReader br = new BufferedReader(new InputStreamReader(in));
			String strLine;
			FileWriter outFile = new FileWriter("OUT2.txt");
			PrintWriter out = new PrintWriter(outFile);
			while ((strLine = br.readLine()) != null)   {
				try {
					String[] lineParts= strLine.split(" ");
					double linePart1 = Integer.parseInt(lineParts[0]);
					double linePart2 = Integer.parseInt(lineParts[1]);
					double lineTotal = linePart1 + linePart2;
					double givenOutPercent = (linePart1 / lineTotal * 100);
					double givenOutPerdix = (givenOutPercent / 10.0);
					int givenOutPerdixInt = (int) givenOutPerdix;
					String lineOutput = "";
					for (int i = 0; i < 10; i++) {
						if (givenOutPerdixInt <= i) {
							lineOutput = lineOutput.concat(".");
						} else {
							lineOutput = lineOutput.concat("*");
						}
					}
					out.println(lineOutput);
				} catch (Exception e) {
					out.println("**********");
				}
			}
			//Close the input stream
			in.close();
			out.close();
				}catch (Exception e){//Catch exception if any
			System.err.println("Error: " + e.getMessage());
		}
	}
}