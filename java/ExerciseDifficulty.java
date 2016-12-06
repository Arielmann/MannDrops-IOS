import java.util.Arrays;
import java.util.List;

/**
 * Created by dekel31 on 10/8/2016.
 */
public enum ExerciseDifficulty {
    EASY(Arrays.asList(
            new ExerciseFactory(Arrays.asList(Operator.MINUS, Operator.PLUS), 10))),
    NORMAL(Arrays.asList(
            new ExerciseFactory(Arrays.asList(Operator.MINUS, Operator.PLUS), 30),
            new ExerciseFactory(Arrays.asList(Operator.DIVIDE, Operator.MULTIPLY), 10)));
//    HARD(Arrays.asList(new ExerciseFactory(Arrays.asList(Operator.MINUS, Operator.PLUS), 45))),
//    CRAZY(Arrays.asList(new ExerciseFactory(Arrays.asList(Operator.MINUS, Operator.PLUS), 45)));

    private final List<ExerciseFactory> factories;

    ExerciseDifficulty(List<ExerciseFactory> factories) {
        this.factories = factories;
    }

    public String generateExercise(){
        //random between all factories
        long random = Math.round(Math.random() * factories.size());
        return factories.get(random).newInstance();
    }

    /*
    *
    * every instance of enum has a list of factories.
    * when generating an exercise we randomally choose
    * a factory from the enum's list (may include add and substruct or add, substruct, multiply and divide).
    *
    * we then generate the emoji based on the enum value, I.E:
    * emoji gets the random operator and the hard coded enum's max number and then generates it self
    * with a new math exercise.
    *
    *
    * generating two new numbers and embedding the with the operator
    * will be done in the EXERCISE FACTORY.
    * */
}