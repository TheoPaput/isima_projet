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
  float[] guess_outputs(float[] inputs)
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
  
  
  
  // adjuste each weights of the neural network in terms of error value
  void adjuste_weights(float[] final_outputs, float[] known_outputs)
  {
    int i, j, k;
    float sum;
    float[] final_errors = new float[output_nodes];
    float[] hidden_errors = new float[hidden_nodes];
    
    init_matrix(final_errors, 0.0);
    init_matrix(hidden_errors, 0.0);
    
    // calcul of the finals errors
    for (i = 0; i < output_nodes; i++) {
      final_errors[i] = known_outputs[i] - final_outputs[i];
    }
    
    // calcul of the hiddens errors
    for (i = 0; i < hidden_nodes; i++) {
      for (j = 0; j < output_nodes; j++) {
        sum = 0.0;
        for (k = 0; k < output_nodes; k++) {
          sum += output_weights[j][k];
        }
        hidden_errors[i] += final_errors[j] * (output_weights[i][j]/sum);
      }
    }
    
    // modify the output_weights
    for (i = 0; i < output_nodes; i++) {
      for (j = 0; j < hidden_nodes; j++) {
        output_weights[i][j] += output_weights[i][j] * final_errors[i] * learning_rate;
      }
    }
    
    //modify the hidden_weights
    for (i = 0; i < hidden_nodes; i++) {
      for (j = 0; j < input_nodes; j++) {
        hidden_weights[i][j] += hidden_weights[i][j] * hidden_errors[i] * learning_rate;
      }
    }
  }
  
  
  
  // Train the network with a set of inputs and a known set of outputs
  void train(float[] inputs, float[] known_outputs)
  {
    float[] final_outputs = guess_outputs(inputs);
    if (!compare(final_outputs,known_outputs))
      adjuste_weights(final_outputs, known_outputs);
  }
  
  
  
  // Compare two matrix
  boolean compare(float[] matrix1, float[] matrix2)
  {
    int i;
    boolean flag = true;
    for (i = 0; i < matrix1.length; i++) {
      flag = flag && (matrix1[i] == matrix2[i]);
    }
    return flag;
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
  float activation(float value)
  {
    return (1/(1+exp(-value)));
  }
  
  
  
  // Initialisation of a matrix with specific value
  void init_matrix(float[] matrix, float value)
  {
    int i;
    for (i = 0; i < matrix.length; i++) {
      matrix[i] = value;
    }
  }
  
  
  
  // Set the learning rate value
  void set_learning_rate(float learning_rate)
  {
    this.learning_rate = learning_rate;
  }
  
  
}