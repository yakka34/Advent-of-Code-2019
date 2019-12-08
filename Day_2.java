public class Main {

    enum Operation {
        MULTIPLY, ADD
    }

    public static void main(String[] args) {
        final int[] values = {1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,10,19,1,19,5,23,2,23,6,27,1,27,5,31,2,6,31,35,1,5,35,39,2,39,9,43,1,43,5,47,1,10,47,51,1,51,6,55,1,55,10,59,1,59,6,63,2,13,63,67,1,9,67,71,2,6,71,75,1,5,75,79,1,9,79,83,2,6,83,87,1,5,87,91,2,6,91,95,2,95,9,99,1,99,6,103,1,103,13,107,2,13,107,111,2,111,10,115,1,115,6,119,1,6,119,123,2,6,123,127,1,127,5,131,2,131,6,135,1,135,2,139,1,139,9,0,99,2,14,0,0};

        for (int noun = 0; noun <= 99; noun++) {
            for (int verb = 0; verb <= 99; verb++) {
                if (runProgram(noun,verb, values.clone()) == 19690720) {
                    System.out.println(String.format("Noun: %d, Verb: %d", noun, verb));
                }
            }
        }
    }

    private static int runProgram(final int value1Override, final int value2Override, final int[] sequence) {
        sequence[1] = value1Override;
        sequence[2] = value2Override;
        for (int i = 0; i < sequence.length; i += 4) {
            final int opcode = sequence[i];
            if (opcode == 1) {
                calculate(Operation.ADD, i+1, i+2, i+3, sequence);
            } else if (opcode == 2) {
                calculate(Operation.MULTIPLY, i+1, i+2, i + 3, sequence);
            } else {
                break;
            }
        }
        return sequence[0];
    }

    private static void calculate(final Operation operation, final int location1, int location2, int location3, final int[] sequence) {
        final int value1 = sequence[sequence[location1]];
        final int value2 = sequence[sequence[location2]];
        final int target = sequence[location3];
        if (operation == Operation.ADD) {
            sequence[target] = value1 + value2;
        } else if (operation == Operation.MULTIPLY) {
            sequence[target] = value1 * value2;
        }
    }
}
