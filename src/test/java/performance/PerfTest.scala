package conduitApp.performance

import com.intuit.karate.gatling.PreDef._
import io.gatling.core.Predef._

import scala.concurrent.duration.DurationInt

import utils.CreateTokens

class PerfTest extends Simulation {

  //CreateTokens.createAccessTokens();

  val protocol = karateProtocol(
    "/api/articles/{articleId}" -> Nil
  )

  protocol.nameResolver = (req, ctx) => req.getHeader("karate-name")

  //val csvFeeder = csv("articles.csv").circular // use a comma separator

  //val tokenFeeder = Iterator.continually(Map("token" -> CreateTokens.getNextToken))

  val createArticle = scenario("Create and delete article")
    //.feed(csvFeeder)
    //.feed(tokenFeeder)
    .exec(karateFeature("classpath:petswagger/features/petswagger-example-4.feature"))

  setUp(
    createArticle.inject(
      atOnceUsers(3),
      //nothingFor(4 seconds),
      //constantUsersPerSec(1) during(3 seconds),
      //constantUsersPerSec(2) during(10 seconds),
      //rampUsersPerSec(2) to 10 during(20 seconds),
      //nothingFor(5 seconds),
      //constantUsersPerSec(1) during (10 seconds)
    ).protocols(protocol)
  )
}