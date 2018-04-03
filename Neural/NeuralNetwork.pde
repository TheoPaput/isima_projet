class NeuralNetwork
{
  int input_nodes;
  int hidden_nodes;
  int output_nodes;
  
  float[][] hidden_weights;
  float[][] output_weights;
  
  float learning_rate;
  
  
  
  // Constructor
  NeuralNetwork(int input_nodes_nbr, int hidden_nodes_nbr, int output_nodes_nbr)
  {
    this.input_nodes = input_nodes_nbr;
    this.hidden_nodes = hidden_nodes_nbr;
    this.output_nodes = output_nodes_nbr;
    this.learning_rate = 1.0;
 
    this.hidden_weights = new float[hidden_nodes][input_nodes];
    this.output_weights = new float[output_nodes][hidden_nodes];
    
    init_weights_matrix(hidden_weights, input_nodes, hidden_nodes, -1.0, 1.0);
    init_weights_matrix(output_weights, output_nodes, hidden_nodes, -1.0, 1.0);
  }
  
  
  
  // Return the outputs matrix for a set of inputs
  float[] get_outputs(float[] inputs)
  {
    int i, j;
    float sum;
    float[] final_outputs = new float[output_nodes];
    float[] hidden_outputs = new float[hidden_nodes];
    
    // hidden_outputs values calcul
    for (i = 0; i < hidden_nodes; i++) {
      sum = 0.0;
      for (j = 0; j < input_nodes; j++) {
        sum += hidden_weights[i][j] * inputs[j];
      }
      hidden_outputs[i] = activation(sum);
    }
    // final_outputs values calcul
    for (i = 0; i < output_nodes; i++){
      sum = 0.0;
      for (j = 0; j < hidden_nodes; j++) {
        sum += output_weights[i][j] * hidden_outputs[j];
      }
      final_outputs[i] = activation(sum);
    }
    
    return final_outputs;
  }
  
  
  
  // Train the network with a set of inputs and a known set of outputs
  void train(float[] inputs, float[] known_outputs)
  {
    
  }
  
  
  // Initialisation of a weights matrix with random specific values
  void init_weights_matrix(float[][] weights, int sizex, int sizey, float min, float max)
  {
    int i, j;
    for (i = 0; i < sizex; i++) {
      for (j = 0; j < sizey; j++) {
        weights[i][j] = random(min, max);
      }
    }
  }
  
  
  
  // Activation fonction
  int activation(float value)
  {
    int flag = 1;
    if (value <= 0)
      flag = -1;
    return flag;
  }
  
  
  
  // Set the learning rate value
  void set_learning_rate(float learning_rate)
  {
    this.learning_rate = learning_rate;
  }
  
  
}