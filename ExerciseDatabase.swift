import Foundation

struct ExerciseDatabase {
    static let exercises: [Exercise] = [
        // РАЗМИНКА
        Exercise(
            title: "Прыжки на скакалке",
            difficulty: .beginner,
            category: .warmup,
            videoURL: "https://www.youtube.com/watch?v=FJmRQ5iTXKE",
            description: """
            Базовое кардио упражнение для разогрева и улучшения координации.
            
            Техника выполнения:
            1. Встаньте прямо, держа скакалку за ручки
            2. Вращайте скакалку кистями рук
            3. Прыгайте на носках, минимально отрываясь от земли
            4. Держите локти близко к телу
            5. Сохраняйте ровное положение спины
            
            Начните с 3 раундов по 3 минуты с минутой отдыха между раундами.
            """,
            tips: [
                "Начинайте с медленного темпа",
                "Дышите ровно и ритмично",
                "Держите взгляд перед собой",
                "Приземляйтесь мягко на носки"
            ],
            commonMistakes: [
                "Слишком высокие прыжки",
                "Широко расставленные локти",
                "Сутулость при прыжках",
                "Неритмичное дыхание"
            ],
            equipment: ["Скакалка"],
            targetMuscles: ["Ноги", "Плечи"],
            estimatedCaloriesBurn: 300,
            recommendedDuration: 1800,
            recommendedRepetitions: nil,
            recommendedSets: nil,
            intervalWork: nil,
            intervalRest: nil
        ),
        
        Exercise(
            title: "Бой с тенью",
            difficulty: .intermediate,
            category: .warmup,
            videoURL: "https://www.youtube.com/watch?v=kqB19LuJ5jE",
            description: """
            Имитация боксерского поединка без противника. Отличное упражнение для разминки и отработки техники.
            
            Ключевые моменты:
            1. Постоянное движение на ногах
            2. Работа в разных темпах
            3. Комбинации ударов
            4. Защитные действия
            5. Работа корпусом
            
            Рекомендуется выполнять 3-5 раундов по 3 минуты.
            """,
            tips: [
                "Представляйте реального соперника",
                "Меняйте темп и ритм",
                "Работайте над защитой",
                "Используйте все виды ударов"
            ],
            commonMistakes: [
                "Отсутствие работы ног",
                "Забывание про защиту",
                "Однообразные действия",
                "Нереалистичная дистанция"
            ],
            equipment: ["Боксерские перчатки (опционально)"],
            targetMuscles: ["Ноги", "Плечи", "Корпус"],
            estimatedCaloriesBurn: 400,
            recommendedDuration: 1800,
            recommendedRepetitions: nil,
            recommendedSets: nil,
            intervalWork: nil,
            intervalRest: nil
        ),
        
        // ТЕХНИКА
        Exercise(
            title: "Джеб",
            difficulty: .beginner,
            category: .technique,
            videoURL: "https://www.youtube.com/watch?v=1D9v6KtBQrk",
            description: """
            Прямой удар передней рукой - основа бокса. Самый быстрый и часто используемый удар.
            
            Техника выполнения:
            1. Примите боевую стойку
            2. Выполните быстрый прямой удар передней рукой
            3. Разверните кулак в конце удара
            4. Быстро верните руку в защитную позицию
            
            Начните с работы по воздуху, затем перейдите к груше или мешку.
            """,
            tips: [
                "Держите вторую руку у подбородка",
                "Не опускайте локоть бьющей руки",
                "Удар должен быть резким и прямым",
                "Возвращайте руку сразу после удара"
            ],
            commonMistakes: [
                "Опускание второй руки",
                "Слишком широкий замах",
                "Удар без разворота кулака",
                "Медленный возврат в стойку"
            ],
            equipment: ["Боксерские перчатки", "Бинты"],
            targetMuscles: ["Плечи", "Руки"],
            estimatedCaloriesBurn: 200,
            recommendedDuration: 300,
            recommendedRepetitions: 10,
            recommendedSets: 3,
            intervalWork: nil,
            intervalRest: nil
        ),
        
        Exercise(
            title: "Хук",
            difficulty: .advanced,
            category: .technique,
            videoURL: "https://www.youtube.com/watch?v=vjxHmGEk8Yo",
            description: """
            Боковой удар, один из самых мощных ударов в боксе.
            
            Техника выполнения:
            1. Из боевой стойки
            2. Согните руку под углом 90 градусов
            3. Разверните корпус в сторону удара
            4. Вложите вес тела в удар
            5. Верните руку в защитную позицию
            
            Важно: Хук требует хорошей координации и баланса.
            """,
            tips: [
                "Держите локоть на уровне кулака",
                "Поворачивайтесь на передней части стопы",
                "Вкладывайте вес тела в удар",
                "Не теряйте равновесие"
            ],
            commonMistakes: [
                "Слишком широкий замах",
                "Опущенный локоть",
                "Нет поворота корпуса",
                "Потеря равновесия"
            ],
            equipment: ["Боксерские перчатки", "Бинты", "Груша"],
            targetMuscles: ["Плечи", "Корпус"],
            estimatedCaloriesBurn: 250,
            recommendedDuration: 300,
            recommendedRepetitions: 10,
            recommendedSets: 3,
            intervalWork: nil,
            intervalRest: nil
        ),
        
        // КОМБИНАЦИИ
        Exercise(
            title: "1-2 (Джеб-Кросс)",
            difficulty: .intermediate,
            category: .combinations,
            videoURL: "https://www.youtube.com/watch?v=7v0_uipNGao",
            description: """
            Базовая комбинация из двух ударов: джеб передней рукой и кросс задней.
            
            Выполнение:
            1. Джеб передней рукой
            2. Сразу следом кросс задней рукой
            3. Быстрый возврат в защитную стойку
            
            Это основная комбинация в боксе, требующая хорошей координации.
            """,
            tips: [
                "Начинайте медленно, постепенно ускоряясь",
                "Держите ритм между ударами",
                "Не забывайте про защиту",
                "Работайте на разных дистанциях"
            ],
            commonMistakes: [
                "Большая пауза между ударами",
                "Телеграфирование ударов",
                "Потеря равновесия",
                "Опускание рук после комбинации"
            ],
            equipment: ["Боксерские перчатки", "Бинты", "Груша/мешок"],
            targetMuscles: ["Плечи", "Руки", "Корпус"],
            estimatedCaloriesBurn: 300,
            recommendedDuration: 300,
            recommendedRepetitions: 10,
            recommendedSets: 3,
            intervalWork: nil,
            intervalRest: nil
        ),
        
        Exercise(
            title: "1-2-3 (Джеб-Кросс-Хук)",
            difficulty: .advanced,
            category: .combinations,
            videoURL: "https://www.youtube.com/watch?v=q1NZZn-tmBU",
            description: """
            Классическая трехударная комбинация, завершающаяся мощным хуком.
            
            Последовательность:
            1. Джеб передней рукой
            2. Кросс задней рукой
            3. Хук передней рукой
            4. Возврат в защитную позицию
            
            Требует хорошей координации и баланса.
            """,
            tips: [
                "Сохраняйте плавность переходов",
                "Не теряйте скорость на последнем ударе",
                "Следите за положением ног",
                "Держите защиту между ударами"
            ],
            commonMistakes: [
                "Потеря равновесия на хуке",
                "Предсказуемый ритм",
                "Отсутствие защиты",
                "Слишком медленные переходы"
            ],
            equipment: ["Боксерские перчатки", "Бинты", "Груша/мешок"],
            targetMuscles: ["Плечи", "Руки", "Корпус"],
            estimatedCaloriesBurn: 350,
            recommendedDuration: 300,
            recommendedRepetitions: 10,
            recommendedSets: 3,
            intervalWork: nil,
            intervalRest: nil
        ),
        
        // Кардио
        Exercise(
            title: "Бег",
            description: "Бег на месте или на улице для улучшения выносливости.",
            difficulty: .beginner,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Держите спину ровно", "Не забывайте дышать"],
            category: .cardio,
            equipment: ["Кроссовки"],
            commonMistakes: ["Слишком высокая скорость", "Неправильная техника"],
            targetMuscles: ["Ноги", "Сердечно-сосудистая система"],
            estimatedCaloriesBurn: 300,
            recommendedDuration: 1800,
            recommendedRepetitions: nil,
            recommendedSets: nil,
            intervalWork: nil,
            intervalRest: nil
        ),
        Exercise(
            title: "Скакалка",
            description: "Отличное кардио упражнение для улучшения координации.",
            difficulty: .intermediate,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Держите локти близко к телу", "Прыгай на носках"],
            category: .cardio,
            equipment: ["Скакалка"],
            commonMistakes: ["Слишком высокие прыжки", "Неправильное положение локтей"],
            targetMuscles: ["Ноги", "Плечи"],
            estimatedCaloriesBurn: 400,
            recommendedDuration: 600,
            recommendedRepetitions: nil,
            recommendedSets: nil,
            intervalWork: nil,
            intervalRest: nil
        ),
        Exercise(
            title: "Велоспорт",
            description: "Велоспорт на месте или на улице для улучшения выносливости.",
            difficulty: .intermediate,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Держите спину ровно", "Не забывайте дышать"],
            category: .cardio,
            equipment: ["Велосипед"],
            commonMistakes: ["Слишком высокая скорость", "Неправильная техника"],
            targetMuscles: ["Ноги", "Сердечно-сосудистая система"],
            estimatedCaloriesBurn: 400,
            recommendedDuration: 1800,
            recommendedRepetitions: nil,
            recommendedSets: nil,
            intervalWork: nil,
            intervalRest: nil
        ),
        Exercise(
            title: "Плавание",
            description: "Плавание для улучшения выносливости.",
            difficulty: .advanced,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Держите спину ровно", "Не забывайте дышать"],
            category: .cardio,
            equipment: ["Бассейн"],
            commonMistakes: ["Слишком высокая скорость", "Неправильная техника"],
            targetMuscles: ["Ноги", "Сердечно-сосудистая система"],
            estimatedCaloriesBurn: 500,
            recommendedDuration: 1800,
            recommendedRepetitions: nil,
            recommendedSets: nil,
            intervalWork: nil,
            intervalRest: nil
        ),
        // Силовые
        Exercise(
            title: "Приседания",
            description: "Силовое упражнение для тренировки ног.",
            difficulty: .beginner,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Держите спину ровно", "Не поднимайте пятки"],
            category: .strength,
            equipment: ["Гантели"],
            commonMistakes: ["Неправильная техника", "Слишком глубокие приседания"],
            targetMuscles: ["Ноги", "Ягодицы"],
            estimatedCaloriesBurn: 200,
            recommendedDuration: 300,
            recommendedRepetitions: 15,
            recommendedSets: 3,
            intervalWork: nil,
            intervalRest: nil
        ),
        Exercise(
            title: "Отжимания",
            description: "Упражнение для тренировки верхней части тела.",
            difficulty: .intermediate,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Держите тело прямым", "Не опускайте голову"],
            category: .strength,
            equipment: ["Нет"],
            commonMistakes: ["Неправильное положение рук", "Слишком низкое опускание"],
            targetMuscles: ["Грудные", "Плечи", "Трицепсы"],
            estimatedCaloriesBurn: 150,
            recommendedDuration: 300,
            recommendedRepetitions: 10,
            recommendedSets: 3,
            intervalWork: nil,
            intervalRest: nil
        ),
        Exercise(
            title: "Жим лежа",
            description: "Силовое упражнение для тренировки груди.",
            difficulty: .intermediate,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Держите спину ровно", "Не поднимайте пятки"],
            category: .strength,
            equipment: ["Гантели"],
            commonMistakes: ["Неправильная техника", "Слишком глубокие приседания"],
            targetMuscles: ["Грудные", "Плечи", "Трицепсы"],
            estimatedCaloriesBurn: 200,
            recommendedDuration: 300,
            recommendedRepetitions: 10,
            recommendedSets: 3,
            intervalWork: nil,
            intervalRest: nil
        ),
        Exercise(
            title: "Тяга",
            description: "Силовое упражнение для тренировки спины.",
            difficulty: .advanced,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Держите спину ровно", "Не поднимайте пятки"],
            category: .strength,
            equipment: ["Гантели"],
            commonMistakes: ["Неправильная техника", "Слишком глубокие приседания"],
            targetMuscles: ["Спина", "Плечи", "Бицепсы"],
            estimatedCaloriesBurn: 250,
            recommendedDuration: 300,
            recommendedRepetitions: 10,
            recommendedSets: 3,
            intervalWork: nil,
            intervalRest: nil
        ),
        // Гибкость
        Exercise(
            title: "Растяжка",
            description: "Упражнение для улучшения гибкости.",
            difficulty: .beginner,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Не спешите", "Дышите глубоко"],
            category: .flexibility,
            equipment: ["Нет"],
            commonMistakes: ["Резкие движения", "Не дотягиваться до предела"],
            targetMuscles: ["Все группы мышц"],
            estimatedCaloriesBurn: 50,
            recommendedDuration: 600,
            recommendedRepetitions: nil,
            recommendedSets: nil,
            intervalWork: nil,
            intervalRest: nil
        ),
        Exercise(
            title: "Разгибание",
            description: "Упражнение для улучшения гибкости.",
            difficulty: .intermediate,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Не спешите", "Дышите глубоко"],
            category: .flexibility,
            equipment: ["Нет"],
            commonMistakes: ["Резкие движения", "Не дотягиваться до предела"],
            targetMuscles: ["Все группы мышц"],
            estimatedCaloriesBurn: 50,
            recommendedDuration: 600,
            recommendedRepetitions: nil,
            recommendedSets: nil,
            intervalWork: nil,
            intervalRest: nil
        ),
        Exercise(
            title: "Сгибание",
            description: "Упражнение для улучшения гибкости.",
            difficulty: .advanced,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Не спешите", "Дышите глубоко"],
            category: .flexibility,
            equipment: ["Нет"],
            commonMistakes: ["Резкие движения", "Не дотягиваться до предела"],
            targetMuscles: ["Все группы мышц"],
            estimatedCaloriesBurn: 50,
            recommendedDuration: 600,
            recommendedRepetitions: nil,
            recommendedSets: nil,
            intervalWork: nil,
            intervalRest: nil
        ),
        // Функциональные
        Exercise(
            title: "Планка",
            description: "Упражнение для укрепления кора.",
            difficulty: .intermediate,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Держите тело прямым", "Не зажимайте плечи"],
            category: .functional,
            equipment: ["Нет"],
            commonMistakes: ["Слишком низко опускаете бедра", "Не держите спину ровно"],
            targetMuscles: ["Кора", "Ноги"],
            estimatedCaloriesBurn: 100,
            recommendedDuration: 120,
            recommendedRepetitions: nil,
            recommendedSets: 3,
            intervalWork: nil,
            intervalRest: nil
        ),
        Exercise(
            title: "Мост",
            description: "Упражнение для укрепления кора.",
            difficulty: .intermediate,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Держите тело прямым", "Не зажимайте плечи"],
            category: .functional,
            equipment: ["Нет"],
            commonMistakes: ["Слишком низко опускаете бедра", "Не держите спину ровно"],
            targetMuscles: ["Кора", "Ноги"],
            estimatedCaloriesBurn: 100,
            recommendedDuration: 120,
            recommendedRepetitions: nil,
            recommendedSets: 3,
            intervalWork: nil,
            intervalRest: nil
        ),
        Exercise(
            title: "Боковая планка",
            description: "Упражнение для укрепления кора.",
            difficulty: .advanced,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Держите тело прямым", "Не зажимайте плечи"],
            category: .functional,
            equipment: ["Нет"],
            commonMistakes: ["Слишком низко опускаете бедра", "Не держите спину ровно"],
            targetMuscles: ["Кора", "Ноги"],
            estimatedCaloriesBurn: 100,
            recommendedDuration: 120,
            recommendedRepetitions: nil,
            recommendedSets: 3,
            intervalWork: nil,
            intervalRest: nil
        ),
        // Интервальные
        Exercise(
            title: "Интервальная тренировка",
            description: "Чередование высокой и низкой интенсивности.",
            difficulty: .advanced,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Слушайте свое тело", "Не забывайте о восстановлении"],
            category: .interval,
            equipment: ["Нет"],
            commonMistakes: ["Переусердствование", "Недостаток отдыха"],
            targetMuscles: ["Все группы мышц"],
            estimatedCaloriesBurn: 500,
            recommendedDuration: 1800,
            recommendedRepetitions: nil,
            recommendedSets: nil,
            intervalWork: 30,
            intervalRest: 30
        ),
        Exercise(
            title: "Хай-интенсивная интервальная тренировка",
            description: "Чередование высокой и низкой интенсивности.",
            difficulty: .advanced,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Слушайте свое тело", "Не забывайте о восстановлении"],
            category: .interval,
            equipment: ["Нет"],
            commonMistakes: ["Переусердствование", "Недостаток отдыха"],
            targetMuscles: ["Все группы мышц"],
            estimatedCaloriesBurn: 500,
            recommendedDuration: 1800,
            recommendedRepetitions: nil,
            recommendedSets: nil,
            intervalWork: 30,
            intervalRest: 30
        ),
        Exercise(
            title: "Низко-интенсивная интервальная тренировка",
            description: "Чередование высокой и низкой интенсивности.",
            difficulty: .advanced,
            videoURL: "https://www.youtube.com/watch?v=example",
            tips: ["Слушайте свое тело", "Не забывайте о восстановлении"],
            category: .interval,
            equipment: ["Нет"],
            commonMistakes: ["Переусердствование", "Недостаток отдыха"],
            targetMuscles: ["Все группы мышц"],
            estimatedCaloriesBurn: 500,
            recommendedDuration: 1800,
            recommendedRepetitions: nil,
            recommendedSets: nil,
            intervalWork: 30,
            intervalRest: 30
        )
    ]
}
