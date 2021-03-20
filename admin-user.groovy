import jenkins.model.*
import hudson.security.*
import hudson.security.csrf.*
import jenkins.security.s2m.AdminWhitelistRule

def jenkins = Jenkins.instance

//enable security
jenkins.setSecurityRealm(new HudsonPrivateSecurityRealm(false))
def authStrategy = new FullControlOnceLoggedInAuthorizationStrategy()
authStrategy.setAllowAnonymousRead(false)
jenkins.setAuthorizationStrategy(authStrategy)

//CSRF protection
jenkins.setCrumbIssuer(new DefaultCrumbIssuer(true))

//disable remoting
jenkins.CLI.get().setEnabled(false)

jenkins.getInjector().getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false)

// Disable old Non-Encrypted protocols
jenkins.getAgentProtocols().removeAll(["JNLP3-connect", "JNLP2-connect", "JNLP-connect", "CLI-connect"]);
jenkins.save()