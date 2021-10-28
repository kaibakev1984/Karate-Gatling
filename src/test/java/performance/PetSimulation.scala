package performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._

import scala.concurrent.duration.DurationInt

class PetSimulation extends Simulation {

  val protocol = karateProtocol(
    "/v2/user/{username}" -> Nil
  )

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  val csvFeeder = csv("user-data.csv.zip").unzip.circular // use a comma separator

  val createUser = scenario("Create and delete user")
    // .feed(csvFeeder)
    .exec(karateFeature("classpath:petswagger/features/user-example-1.feature"))

  setUp(
    createUser.inject(
      atOnceUsers(10),
      nothingFor(4 seconds),
      // constantUsersPerSec(1) during(3 seconds),
      // constantUsersPerSec(2) during(10 seconds),
      // rampUsersPerSec(2) to 10 during(20 seconds),
      // nothingFor(5 seconds),
      // constantUsersPerSec(1) during (10 seconds)
    ).protocols(protocol)
  )
}