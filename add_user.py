from app import db, User, bcrypt, app

with app.app_context():
    # Create a sample user
    hashed_password = bcrypt.generate_password_hash('password123').decode('utf-8')
    user = User(username='admin', email='admin@example.com', password=hashed_password)
    db.session.add(user)
    db.session.commit()
    print("User created: username='admin', password='password123'")