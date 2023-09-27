public class DNA{
    float[] genes = new float[109+4];
    float fitness;

    DNA(){
        for(int i = 0; i < genes.length; i++){
            genes[i] =  random(-1,1);
        }
    }

    void mutate(float mutationRate){
        for(int i=0;i<genes.length;i++){
            if(random(1.0)<mutationRate){
                genes[i] = random(-1,1);
            }
        }
    }

    DNA crossover(DNA partner){
        DNA child = new DNA();
        for(int i=0;i<genes.length;i++){
            if(random(1.0)>0.5){
                child.genes[i] = this.genes[i];
            }
            else{
                child.genes[i] = partner.genes[i];
            }
        }
        return child;
    }

    void fitness(){
        // int score = 0;
        // for (int i = 0;i<genes.length;i++){
        //     if(genes[i] == target.charAt(i)){
        //         score++;
        //     }
        // }
        // this.fitness = float(score)/target.length();
    }
}