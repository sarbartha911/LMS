CREATE TABLE `access` (
  `access_id` int NOT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `pwd` varchar(50) DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `instructor_id` int DEFAULT NULL,
  PRIMARY KEY (`access_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `answers` (
  `answer_id` int NOT NULL,
  `question_id` int DEFAULT NULL,
  `chosen_option` varchar(1) NOT NULL,
  PRIMARY KEY (`answer_id`),
  KEY `FK_eques_anw` (`question_id`),
  CONSTRAINT `FK_eques_anw` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `attendance` (
  `attendance_id` int NOT NULL,
  `student_id` int NOT NULL,
  `date` date NOT NULL,
  `is_present` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`attendance_id`),
  KEY `FK_attend_stud` (`student_id`),
  CONSTRAINT `FK_attend_stud` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `chapter_content` (
  `content_id` int NOT NULL,
  `course_chapter_id` int DEFAULT NULL,
  `content_type_id` int DEFAULT NULL,
  `is_mandatory` tinyint(1) DEFAULT NULL,
  `time_required_in_secs` int DEFAULT NULL,
  PRIMARY KEY (`content_id`),
  KEY `FK_Course_Chapter` (`course_chapter_id`),
  KEY `FK_Chapter_ContentType` (`content_type_id`),
  CONSTRAINT `FK_Chapter_ContentType` FOREIGN KEY (`content_type_id`) REFERENCES `content_type` (`content_type_id`),
  CONSTRAINT `FK_Course_Chapter` FOREIGN KEY (`course_chapter_id`) REFERENCES `course_chapter` (`chapter_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `content_type` (
  `content_type_id` int NOT NULL,
  `content_type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`content_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `course` (
  `course_id` int NOT NULL,
  `course_title` varchar(50) DEFAULT NULL,
  `course_brief` varchar(50) DEFAULT NULL,
  `no_of_chapters` int DEFAULT NULL,
  `course_fee` float DEFAULT NULL,
  `language_id` int DEFAULT NULL,
  PRIMARY KEY (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `course_chapter` (
  `chapter_id` int NOT NULL,
  `course_id` int DEFAULT NULL,
  `instructor_id` int NOT NULL,
  `chapter_title` varchar(50) DEFAULT NULL,
  `no_of_enrolled` int DEFAULT NULL,
  `no_of_videos` int DEFAULT NULL,
  `no_of_assignments` int DEFAULT NULL,
  PRIMARY KEY (`chapter_id`),
  KEY `FK_chapter_course_idx` (`course_id`),
  KEY `FK_chapter_instruc` (`instructor_id`),
  CONSTRAINT `FK_chapter_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`),
  CONSTRAINT `FK_chapter_instruc` FOREIGN KEY (`instructor_id`) REFERENCES `instructor` (`instructor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `difficulty_level` (
  `level_id` int NOT NULL,
  `question_id` int DEFAULT NULL,
  `difficulty_level` int DEFAULT NULL,
  PRIMARY KEY (`level_id`),
  KEY `FK_level_question` (`question_id`),
  CONSTRAINT `FK_level_question` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `enrolment` (
  `enrolment_id` int NOT NULL,
  `student_id` int DEFAULT NULL,
  `course_id` int DEFAULT NULL,
  `enrolment_date` date DEFAULT NULL,
  `is_paid` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`enrolment_id`),
  KEY `student_id` (`student_id`),
  KEY `FK_course_instructor` (`course_id`),
  CONSTRAINT `enrolment_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  CONSTRAINT `FK_course_instructor` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `exam` (
  `exam_id` int NOT NULL,
  `course_id` int DEFAULT NULL,
  `exam_date` date DEFAULT NULL,
  `exam_name` varchar(50) DEFAULT NULL,
  `exam_desc` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`exam_id`),
  KEY `FL_course_exam` (`course_id`),
  CONSTRAINT `FL_course_exam` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `exam_questions` (
  `exam_id` int NOT NULL,
  `question_id` int NOT NULL,
  KEY `FK_exam_ques_exam` (`exam_id`),
  KEY `FK_eques_anw` (`question_id`),
  CONSTRAINT `FK_exam_ques_exam` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`exam_id`),
  CONSTRAINT `FK_exam_ques_ques` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `feedback` (
  `feedback_id` int NOT NULL,
  `enrolment_id` int DEFAULT NULL,
  `rating_score` float DEFAULT NULL,
  `feedback_text` varchar(1000) DEFAULT NULL,
  `submission_date` date DEFAULT NULL,
  PRIMARY KEY (`feedback_id`),
  KEY `FK_enrol_feedbk` (`enrolment_id`),
  CONSTRAINT `FK_enrol_feedbk` FOREIGN KEY (`enrolment_id`) REFERENCES `enrolment` (`enrolment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `instructor` (
  `instructor_id` int NOT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `pwd` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `mobile` decimal(15,0) DEFAULT NULL,
  `date_of_regn` date DEFAULT NULL,
  `qualification` varchar(50) DEFAULT NULL,
  `introduction` varchar(50) DEFAULT NULL,
  `no_of_courses_published` int DEFAULT NULL,
  `no_of_students_enrolled` int DEFAULT NULL,
  `avg_review_rating` float DEFAULT NULL,
  `no_of_reviews` int DEFAULT NULL,
  PRIMARY KEY (`instructor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `learning_progress` (
  `progress_id` int NOT NULL,
  `enrolment_id` int DEFAULT NULL,
  `content_id` int DEFAULT NULL,
  `begin_timestamp` timestamp NULL DEFAULT NULL,
  `completion_timestamp` timestamp NULL DEFAULT NULL,
  `current_status` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`progress_id`),
  KEY `FK_prog_enrol` (`enrolment_id`),
  KEY `FK_content_prog` (`content_id`),
  CONSTRAINT `FK_content_prog` FOREIGN KEY (`content_id`) REFERENCES `chapter_content` (`content_id`),
  CONSTRAINT `FK_prog_enrol` FOREIGN KEY (`enrolment_id`) REFERENCES `enrolment` (`enrolment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `payment_method` (
  `payment_method_id` int NOT NULL,
  `payment_method_description` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `questions` (
  `question_id` int NOT NULL,
  `course_id` int NOT NULL,
  `question_text` varchar(1000) DEFAULT NULL,
  `option1` varchar(250) DEFAULT NULL,
  `option2` varchar(250) DEFAULT NULL,
  `option3` varchar(250) DEFAULT NULL,
  `option4` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`question_id`),
  KEY `FK_ques_course_idx` (`course_id`),
  CONSTRAINT `FK_ques_course` FOREIGN KEY (`course_id`) REFERENCES `course` (`course_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `student` (
  `student_id` int NOT NULL,
  `date_of_regn` date DEFAULT NULL,
  `date_last_login` date DEFAULT NULL,
  `userid` varchar(50) DEFAULT NULL,
  `pwd` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `mobile` decimal(15,0) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `no_of_enrolled_courses` decimal(4,0) DEFAULT NULL,
  `no_of_courses_completed` decimal(4,0) DEFAULT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `student_answer` (
  `stud_ans_id` int NOT NULL,
  `exam_id` int NOT NULL,
  `question_id` int NOT NULL,
  `student_id` int NOT NULL,
  `date_of_answer` date DEFAULT NULL,
  `chosen_answer` varchar(20) DEFAULT NULL,
  `comment` varchar(50) DEFAULT NULL,
  `is_correct` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`stud_ans_id`),
  KEY `FK_stud_ans_exam` (`exam_id`),
  KEY `FK_stud_ans_quest` (`question_id`),
  KEY `FK_stud_ans_stud` (`student_id`),
  CONSTRAINT `FK_stud_ans_exam` FOREIGN KEY (`exam_id`) REFERENCES `exam` (`exam_id`),
  CONSTRAINT `FK_stud_ans_quest` FOREIGN KEY (`question_id`) REFERENCES `questions` (`question_id`),
  CONSTRAINT `FK_stud_ans_stud` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `student_assessment` (
  `assessment_id` int NOT NULL,
  `stud_ans_id` int NOT NULL,
  `answer_id` int NOT NULL,
  `is_correct` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`assessment_id`),
  KEY `FK_stud_assess_stud_ans` (`stud_ans_id`),
  KEY `FK_stud_assess_ans` (`answer_id`),
  CONSTRAINT `FK_stud_assess_ans` FOREIGN KEY (`answer_id`) REFERENCES `answers` (`answer_id`),
  CONSTRAINT `FK_stud_assess_stud_ans` FOREIGN KEY (`stud_ans_id`) REFERENCES `student_answer` (`stud_ans_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `stud_payment_method` (
  `stu_pay_method_id` int NOT NULL,
  `payment_method_id` int DEFAULT NULL,
  `student_id` int DEFAULT NULL,
  `bank_details` varchar(50) DEFAULT NULL,
  `card_details` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`stu_pay_method_id`),
  KEY `FK_stud_pay_meth` (`student_id`),
  KEY `FK_stud_pay_pay_meth` (`payment_method_id`),
  CONSTRAINT `FK_stud_pay_meth` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`),
  CONSTRAINT `FK_stud_pay_pay_meth` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_method` (`payment_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

