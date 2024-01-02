import 'model/subject.dart';
import '../ui/theme/app_color.dart';

final List<Subject> subjects = [
  Subject(
    id: 1,
    slug: "digital-arts",
    name: "Digital Arts",
    desc: "Become a proficient Digital Artist",
    lecturer: "Prof. Josh Kurtman",
    image: "assets/images/digital_arts.png",
    gradient: [AppColor.purpleGradientStart, AppColor.purpleGradientEnd],
  ),
  Subject(
    id: 2,
    slug: "network-security",
    name: "Network Security",
    desc: "Securing network, securing the world",
    lecturer: "Prof. Yelena Karpov",
    image: "assets/images/network_security.png",
    gradient: [AppColor.cyanGradientStart, AppColor.cyanGradientEnd],
  ),
  Subject(
    id: 3,
    slug: "finance",
    name: "Finance",
    desc: "Let's achieve financial freedom!",
    lecturer: "Maria Inge",
    image: "assets/images/finance.png",
    gradient: [AppColor.orangeGradientStart, AppColor.orangeGradientEnd],
  ),
  Subject(
    id: 4,
    slug: "mobile-dev",
    name: "Mobile Dev",
    desc: "Develop miracle within your grip",
    lecturer: "Prof. Jorgen Faucsh",
    image: "assets/images/mobile_dev.png",
    gradient: [AppColor.pinkGradientStart, AppColor.pinkGradientEnd],
  ),
];