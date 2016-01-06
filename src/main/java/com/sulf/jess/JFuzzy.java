/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.sulf.jess;

import jess.JessException;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*;

public class JFuzzy {

    private static GUI gui;
    private static String filePath = new File("").getAbsolutePath();
    private static String path = "/src/main/java/scripts";
    private static Process p;
    private static File f;
    private static InputStream inputStream;
    private static String output;
    private static StringBuilder builder;

    public static void main(String[] args) {

        gui = new GUI();
        gui.setSize(400,400);
        gui.setResizable(false);
        gui.getWnioskujButton().addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                try {
                    processOrder();
                }catch(JessException ex){
                    ex.printStackTrace();
                }
            }
        });
    }

    private static void processOrder() throws JessException {

        output = filePath.concat("/src/main/java/output/wyniki.txt");

        File file = new File(output);

        if(file.delete()){
            System.out.println(file.getName() + " is deleted!");
        }
        gui.getTextArea1().setText(null);

        double poziomPaliwa = gui.getSlider1().getValue();
        double predkosc = gui.getSlider2().getValue();

        PrintWriter writer = null;

        try {
                writer = new PrintWriter(filePath.concat(path + "/zmienne.clp"));
                writer.write("(defglobal ?*poziomPal* = " + poziomPaliwa + " )" + "\n");
                writer.write("(defglobal ?*predk* = " + predkosc + " )" + "\n");
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } finally {
            try {
                writer.close();
            }catch (NullPointerException e) {}
        }

        try {

            String s = null;

            if (System.getProperty("os.name").equals("Linux")) {

                p = Runtime.getRuntime().exec(filePath.concat(path + "/jess " + path + "/silnik.clp"));

                BufferedReader stdInput = new BufferedReader(new
                        InputStreamReader(p.getInputStream()));

                while ((s = stdInput.readLine()) != null) {
                    System.out.println(s);
                }
            }
            else{
                p = Runtime.getRuntime().exec(filePath.concat(path + "/jess.bat " + path + "/silnik.clp"));

                BufferedReader stdInput = new BufferedReader(new
                        InputStreamReader(p.getInputStream()));

                while ((s = stdInput.readLine()) != null) {
                    System.out.println(s);
                }
            }
            f = new File(output);
            inputStream = new FileInputStream(f);
            builder = new StringBuilder();

            while(f == null || !f.exists()){}
            updateTextField();

        } catch (IOException ex) {}
    }

    private static void updateTextField(){
        try {
            if (f != null && f.exists()) {
                int ch;
                while ((ch = inputStream.read()) != -1) {
                    builder.append((char) ch);
                }
                gui.getTextArea1().setText(builder.toString());
            }
        }catch (IOException e){System.out.print("error");}
    }
}
