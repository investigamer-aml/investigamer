# Define the database schema for the Users Table as part of the educational platform

from sqlalchemy import create_engine, Column, Integer, String, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship, sessionmaker

Base = declarative_base()

class User(Base):
    __tablename__ = 'users'
    
    id = Column(Integer, primary_key=True)
    name = Column(String)
    email = Column(String, unique=True)
    hashed_password = Column(String)
    # Establishing a relationship with the UserAnswers table
    answers = relationship("UserAnswer", back_populates="user")
    
class Question(Base):
    __tablename__ = 'questions'
    
    id = Column(Integer, primary_key=True)
    text = Column(String)
    difficulty_level = Column(String)
    risk_factors = Column(String)
    question_type = Column(String)  # Normal or Edge Case
    # Establishing a relationship with the UserAnswers table
    answers = relationship("UserAnswer", back_populates="question")
    
class UserAnswer(Base):
    __tablename__ = 'user_answers'
    
    id = Column(Integer, primary_key=True)
    user_id = Column(Integer, ForeignKey('users.id'))
    question_id = Column(Integer, ForeignKey('questions.id'))
    answer_given = Column(String)
    is_correct = Column(String)
    # Establishing relationships back to User and Question
    user = relationship("User", back_populates="answers")
    question = relationship("Question", back_populates="answers")

# Placeholder for other tables and relationships (Learning Paths, Risk Assessments)

# Code to create the database and tables would go here, using SQLAlchemy's create_engine
# and Base.metadata.create_all(engine) commands, specifying the PostgreSQL connection string.

# This is a foundational step before moving onto API development with FastAPI and integrating this schema.

